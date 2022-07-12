module Messaging
  module Handle
    class Error < RuntimeError; end

    def self.included(cls)
      cls.class_exec do
        include Dependency
        include Virtual

        def handler_logger
          @handler_logger ||= Log.get(self)
        end
        attr_writer :handler_logger

        extend Build
        extend Call
        extend Info
        extend HandleMacro
        extend MessageRegistry

        virtual :configure

        attr_writer :strict
      end
    end

    module Build
      Error = Class.new(RuntimeError)

      def build(strict: nil, session: nil, settings: nil)
        instance = new
        instance.strict = strict

        arguments = {}

        if Build.send_session?(session, instance)
          arguments[:session] = session
        end

        if Build.send_settings?(settings, instance)
          arguments[:settings] = settings
        end

        instance.configure(**arguments)

        instance
      end

      def self.send_session?(session, instance)
        configure?(instance, :session) && !session.nil?
      end

      def self.send_settings?(settings, instance)
        configure?(instance, :settings) && !settings.nil?
      end

      def self.configure?(instance, parameter_name)
        configure_method = instance.method(:configure)

        parameter_type, _ = configure_method.parameters.find do |type, name|
          name == parameter_name
        end

        return false if parameter_type.nil?

        return true if [:key, :keyreq].include?(parameter_type)

        error_message = "Incorrect definition of handler's configure method. The #{parameter_name} parameter must be a keyword argument (Handler: #{instance.class}, Parameter Type: #{parameter_type.inspect})"
        handler_logger.error(tag: :handle) { error_message }
        raise Error, error_message
      end

      def self.handler_logger
        @handler_logger ||= Log.get(self)
      end
    end

    module Call
      def call(message_or_message_data, strict: nil, session: nil, settings: nil)
        instance = build(strict: strict, session: session, settings: settings)
        instance.(message_or_message_data)
      end
    end

    module Info
      extend self

      def handler(message_or_message_data)
        handler_method_name = handler_method_name(message_or_message_data)

        if method_defined?(handler_method_name)
          return handler_method_name
        else
          return nil
        end
      end

      def handles?(message_or_message_data)
        method_defined? handler_method_name(message_or_message_data)
      end

      def handler_method_name(message_or_message_data)
        name = nil

        if message_or_message_data.is_a? MessageStore::MessageData::Read
          name = Messaging::Message::Info.canonize_name(message_or_message_data.type)
        elsif message_or_message_data.is_a? String
          name = Messaging::Message::Info.canonize_name(message_or_message_data)
        else
          name = message_or_message_data.message_name
        end

        "handle_#{name}".to_sym
      end
    end

    module HandleMacro
      class Error < RuntimeError; end

      def handler_logger
        @handler_logger ||= Log.get(self)
      end

      def handle_macro(message_class, &blk)
        handler_method_name = define_handler_method(message_class, &blk)

        message_registry.register(message_class)

        handler_method_name
      end
      alias :handle :handle_macro

      def define_handler_method(message_class, &blk)
        handler_method_name = handler_method_name(message_class)

        if blk.nil?
          error_msg = "Handler for #{message_class.name} is not correctly defined. It must have a block."
          handler_logger.error(tag: :handle) { error_msg }
          raise Error, error_msg
        end

        send(:define_method, handler_method_name, &blk)

        handler_method = instance_method(handler_method_name)

        unless handler_method.arity == 1
          error_msg = "Handler for #{message_class.name} is not correctly defined. It can only have a single parameter."
          handler_logger.error(tag: :handle) { error_msg }
          raise Error, error_msg
        end

        handler_method_name
      end
    end

    module MessageRegistry
      def message_registry
        @message_registry ||= Messaging::MessageRegistry.new
      end
    end

    def strict
      @strict ||= Defaults.strict
    end
    alias :strict? :strict

    def call(message_or_message_data, strict: nil)
      if message_or_message_data.is_a? Message
        handle_message(message_or_message_data, strict: strict)
      else
        handle_message_data(message_or_message_data, strict: strict)
      end
    end

    def handle_message(message, strict: nil)
      strict ||= self.strict?

      handler_logger.trace(tags: [:dispatch, :message]) { "Dispatching message (Message class: #{message.class.name})" }
      handler_logger.trace(tags: [:data, :message]) { message.pretty_inspect }

      handler = self.class.handler(message)

      unless handler.nil?
        message_type = message.message_type

        handler_logger.trace(tag: [:handle, :message]) { "Handling Message (Type: #{message_type}, Method: #{handler})" }

        public_send(handler, message)

        handler_logger.info(tags: [:handle, :message]) { "Handled message (Message class: #{message.class.name})" }
        handler_logger.info(tags: [:data, :message]) { message.pretty_inspect }
      else
        if strict
          error_msg = "#{self.class.name} does not implement a handler for #{message.message_type}. Cannot handle the message."
          handler_logger.error(tag: :handle) { error_msg }
          raise Error, error_msg
        end
      end

      message
    end

    def handle_message_data(message_data, strict: nil)
      strict ||= self.strict?

      handler_logger.trace(tags: [:dispatch, :message_data]) { "Dispatching message data (Type: #{message_data.type})" }
      handler_logger.trace(tags: [:data, :message_data]) { message_data.pretty_inspect }

      message = nil

      handler = self.class.handler(message_data)

      unless handler.nil?
        message_type = message_data.type
        message_name = Messaging::Message::Info.canonize_name(message_type)
        message_class = self.class.message_registry.get(message_name)

        if message_class == nil
          error_msg = "No message class is registered (Message Type: #{message_type}, Handler: #{self.class.name})"
          handler_logger.error(tag: :handle) { error_msg }
          raise Error, error_msg
        end

        message = Message::Import.(message_data, message_class)

        message_type = message.message_type

        handler_logger.trace(tag: [:handle, :message_data]) { "Handling Message Data (Type: #{message_type}, Method: #{handler})" }

        public_send(handler, message)

        handler_logger.info(tags: [:handle, :message_data]) { "Handled message data (Type: #{message_data.type})" }
        handler_logger.info(tags: [:data, :message_data]) { message_data.pretty_inspect }
      else
        if respond_to?(:handle)
          message_type = message_data.type
          handler_logger.trace(tag: [:handle, :message_data]) { "Handling Message Data (Type: #{message_type}, Method: handle" }

          handle(message_data)

          handler_logger.info(tags: [:handle, :message_data]) { "Handled message data (Type: #{message_data.type})" }
          handler_logger.info(tags: [:data, :message_data]) { message_data.pretty_inspect }

          message = message_data
        else
          if strict
            error_msg = "#{self.class.name} does not implement `handle'. Cannot handle message data."
            handler_logger.error(tag: :handle) { error_msg }
            raise Error, error_msg
          end
        end
      end

      message
    end
  end
end

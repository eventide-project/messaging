module Messaging
  module Handle
    class Error < RuntimeError; end

    def self.included(cls)
      cls.class_exec do
        dependency :handler_logger, ::Log

        cls.extend Build
        cls.extend Call
        cls.extend Info
        cls.extend HandleMacro
        cls.extend MessageRegistry

        virtual :configure

        attr_writer :strict
      end
    end

    module Build
      def build(strict: nil, session: nil)
        instance = new
        instance.strict = strict
        Log.configure(instance, attr_name: :handler_logger)

        if Build.configure_session?(instance)
          instance.configure(session: session)
        else
          instance.configure
        end

        instance
      end

      def self.configure_session?(instance)
        configure_method = instance.method(:configure)

        parameter_type, _ = configure_method.parameters.find do |type, name|
          name == :session
        end

        return false if parameter_type.nil?

        return true if parameter_type == :key

        error_message = "Optional session parameter of configure is not a keyword argument (Type: #{parameter_type.inspect})"
        logger.error { error_message }
        raise ArgumentError, error_message
      end

      def self.logger
        @logger ||= Log.build(self)
      end
    end

    module Call
      def call(message_or_message_data, strict: nil, session: nil)
        instance = build(strict: strict, session: session)
        instance.(message_or_message_data)
      end
    end

    module Info
      extend self

      def handler(message_or_message_data)
        name = handler_name(message_or_message_data)

        if method_defined?(name)
          return name
        else
          return nil
        end
      end

      def handles?(message_or_message_data)
        method_defined? handler_name(message_or_message_data)
      end

      def handler_name(message_or_message_data)
        name = nil

        if message_or_message_data.is_a? MessageStore::MessageData::Read
          name = Messaging::Message::Info.canonize_name(message_or_message_data.type)
        else
          name = message_or_message_data.message_name
        end

        "handle_#{name}"
      end
    end

    module HandleMacro
      class Error < RuntimeError; end

      def handler_logger
        @handler_logger ||= Log.get(self)
      end

      def handle_macro(message_class, &blk)
        define_handler_method(message_class, &blk)
        message_registry.register(message_class)
      end
      alias :handle :handle_macro

      def define_handler_method(message_class, &blk)
        handler_method_name = handler_name(message_class)

        if blk.nil?
          error_msg = "Handler for #{message_class.name} is not correctly defined. It must have a block."
          handler_logger.error { error_msg }
          raise Error, error_msg
        end

        send(:define_method, handler_method_name, &blk)

        handler_method = instance_method(handler_method_name)

        unless handler_method.arity == 1
          error_msg = "Handler for #{message_class.name} is not correctly defined. It can only have a single parameter."
          handler_logger.error { error_msg }
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

      handler_logger.trace(tags: [:handle, :message]) { "Handling message (Message class: #{message.class.name})" }
      handler_logger.trace(tags: [:data, :message, :handle]) { message.pretty_inspect }

      handler = self.class.handler(message)

      unless handler.nil?
        message_type = message.message_type

        handler_logger.debug("Handling Message (Type: #{message_type}, Method: #{handler})")
        public_send(handler, message)
      else
        if strict
          error_msg = "#{self.class.name} does not implement a handler for #{message.message_type}. Cannot handle the message."
          handler_logger.error { error_msg }
          raise Error, error_msg
        end
      end

      handler_logger.info(tags: [:handle, :message]) { "Handled message (Message class: #{message.class.name})" }
      handler_logger.info(tags: [:data, :message, :handle]) { message.pretty_inspect }

      message
    end

    def handle_message_data(message_data, strict: nil)
      strict ||= self.strict?

      handler_logger.trace(tags: [:handle, :message_data]) { "Handling message data (Type: #{message_data.type})" }
      handler_logger.trace(tags: [:data, :message_data, :handle]) { message_data.pretty_inspect }

      message = nil

      handler = self.class.handler(message_data)

      unless handler.nil?
        message_type = message_data.type
        message_name = Messaging::Message::Info.canonize_name(message_type)
        message_class = self.class.message_registry.get(message_name)

        if message_class == nil
          raise Error, "No message class is registered (Message Type: #{message_type}, Handler: #{self.class.name})"
        end

        message = Message::Import.(message_data, message_class)

        message_type = message.message_type

        handler_logger.debug("Handling Message (Type: #{message_type}, Method: #{handler})")
        public_send(handler, message)
      else
        if respond_to?(:handle)
          message_type = message_data.type
          handler_logger.debug("Handling Message Data (Type: #{message_type}, Method: handle")

          message = handle(message_data)
        else
          if strict
            error_msg = "#{self.class.name} does not implement `handle'. Cannot handle message data."
            handler_logger.error { error_msg }
            raise Error, error_msg
          end
        end
      end

      handler_logger.info(tags: [:handle, :message_data]) { "Handled message data (Type: #{message_data.type})" }
      handler_logger.info(tags: [:data, :message_data, :handle]) { message_data.pretty_inspect }

      message
    end
  end
end

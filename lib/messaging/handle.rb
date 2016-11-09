module Messaging
  module Handle
    class Error < RuntimeError; end

    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        cls.extend Build
        cls.extend Call
        cls.extend Info
        cls.extend HandleMacro
        cls.extend MessageRegistry

        virtual :configure

        attr_writer :strict
      end
    end

    def strict
      @strict ||= false
    end

    module Build
      def build(strict: nil)
        instance = new
        instance.strict = strict
        instance.configure
        instance
      end
    end

    module Call
      def call(message_or_event_data, strict: nil)
        instance = build(strict: strict)
        instance.(message_or_event_data)
      end
    end

    module Info
      extend self

      def handler(message_or_event_data)
        name = handler_name(message_or_event_data)

        if method_defined?(name)
          return name
        else
          return nil
        end
      end

      def handles?(message_or_event_data)
        method_defined? handler_name(message_or_event_data)
      end

      def handler_name(message_or_event_data)
        name = nil

        if message_or_event_data.is_a? EventSource::EventData::Read
          name = Messaging::Message::Info.canonize_name(message_or_event_data.type)
        else
          name = message_or_event_data.message_name
        end

        "handle_#{name}"
      end
    end

    module HandleMacro
      class Error < RuntimeError; end

      def logger
        @logger ||= Log.get(self)
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
          logger.error { error_msg }
          raise Error, error_msg
        end

        send(:define_method, handler_method_name, &blk)

        handler_method = instance_method(handler_method_name)

        unless handler_method.arity == 1
          error_msg = "Handler for #{message_class.name} is not correctly defined. It can only have a single parameter."
          logger.error { error_msg }
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

    def call(message_or_event_data)
      if message_or_event_data.is_a? Message
        handle_message(message_or_event_data)
      else
        handle_event_data(message_or_event_data)
      end
    end

    def handle_message(message)
      logger.trace(tags: [:handle, :message]) { "Handling message (Message class: #{message.class.name})" }
      logger.trace(tags: [:data, :message, :handle]) { message.pretty_inspect }

      handler = self.class.handler(message)

      unless handler.nil?
        public_send(handler, message)
      else
        if strict
          error_msg = "#{self.class.name} does not implement a handler for #{message.message_type}. Cannot handle the message."
          logger.error { error_msg }
          raise Error, error_msg
        end
      end

      logger.info(tags: [:handle, :message]) { "Handled message (Message class: #{message.class.name})" }
      logger.trace(tags: [:data, :message, :handle]) { message.pretty_inspect }

      message
    end

    def handle_event_data(event_data)
      logger.trace(tags: [:handle, :event_data]) { "Handling event data (Type: #{event_data.type})" }
      logger.trace(tags: [:data, :event_data, :handle]) { event_data.pretty_inspect }

      res = nil

      handler = self.class.handler(event_data)

      unless handler.nil?
        message_name = Messaging::Message::Info.canonize_name(event_data.type)
        message_class = self.class.message_registry.get(message_name)
        res = Message::Import.(event_data, message_class)
        public_send(handler, res)
      else
        if respond_to?(:handle)
          res = handle(event_data)
        else
          if strict
            error_msg = "#{self.class.name} does not implement `handle'. Cannot handle event data."
            logger.error { error_msg }
            raise Error, error_msg
          end
        end
      end

      logger.info(tags: [:handle, :event_data]) { "Handled event data (Type: #{event_data.type})" }
      logger.info(tags: [:data, :event_data, :handle]) { event_data.pretty_inspect }

      res
    end
  end
end

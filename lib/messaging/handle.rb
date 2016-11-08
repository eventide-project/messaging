module Messaging
  module Handle
    class Error < RuntimeError; end

    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        dependency :telemetry, ::Telemetry

        cls.extend Build
        cls.extend Call
        cls.extend Info

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
        ::Telemetry.configure instance
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

        if message_or_event_data.is_a? Messaging::Message
          name = message_or_event_data.class.message_name
        else
          name = Messaging::Message::Info.canonize_name(message_or_event_data.type)
        end

        "handle_#{name}"
      end
    end

    def call(message_or_event_data)
      if message_or_event_data.is_a? Message
        dispatch_message(message_or_event_data)
      else
        dispatch_event_data(message_or_event_data)
      end
    end

    def dispatch_message(message)
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

      message
    end

    def dispatch_event_data(event_data)
      res = nil

      handler = self.class.handler(event_data)

      unless handler.nil?
        res = Message::Import.(event_data, Controls::Message::SomeMessage)
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

      res
    end
  end
end

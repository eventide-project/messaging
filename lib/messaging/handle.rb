module Messaging
  module Handle
    class Error < RuntimeError; end

    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        dependency :telemetry, ::Telemetry

        cls.extend Build
        cls.extend Call

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

    def call(message_or_event_data)
      dispatch_event_data(message_or_event_data)
    end

    def dispatch_event_data(event_data)
      if respond_to?(:handle)
        handle(event_data)
      else
        if strict
          error_msg = "#{self.class.name} does not implement `handle'. Cannot handle event data."
          logger.error { error_msg }
          raise Error, error_msg
        end
      end
    end
  end
end

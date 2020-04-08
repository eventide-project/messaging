module Messaging
  class MessageRegistry
    class Error < RuntimeError; end

    include Log::Dependency

    def message_classes
      @message_classes ||= []
    end

    def message_types
      message_classes.map do |message_class|
        message_class.message_type
      end
    end

    def get(message_name)
      message_classes.find do |message_class|
        message_class.message_name == message_name
      end
    end

    def register(message_class)
      logger.trace { "Registering #{message_class}"}
      if registered?(message_class)
        error_msg = "#{message_class} is already registered"
        logger.error { error_msg }
        raise Error, error_msg
      end

      message_classes << message_class

      logger.debug { "Registered #{message_class}"}

      message_classes
    end

    def registered?(message_class)
      message_classes.include?(message_class)
    end

    def length
      message_classes.length
    end
  end
end

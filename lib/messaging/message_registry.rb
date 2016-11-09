module Messaging
  class MessageRegistry
    class Error < RuntimeError; end

    include Log::Dependency

    def entries
      @entries ||= []
    end

    def get(message_name)
      entries.find do |message_class|
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

      entries << message_class

      logger.debug { "Registered #{message_class}"}

      entries
    end

    def registered?(message_class)
      entries.include?(message_class)
    end

    def length
      entries.length
    end
  end
end

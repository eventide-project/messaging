module Messaging
  module Write
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        cls.extend Build
        cls.extend Call
        cls.extend Configure

        dependency :event_writer

        abstract :configure
      end
    end

    module Build
      def build(partition: nil, session: nil)
        instance = new
        instance.configure(partition: partition, session: session)
        instance
      end
    end

    module Configure
      def configure(receiver, partition: nil, session: nil, attr_name: nil)
        attr_name ||= :writer
        instance = build(partition: partition, session: session)
        receiver.public_send "#{attr_name}=", instance
      end
    end

    module Call
      def call(message, stream_name, partition: nil, session: nil)
        instance = build(partition: partition, session: session)
        instance.(message, stream_name)
      end
    end

    def call(message, stream_name, expected_version: nil)
      logger.trace { "Writing message (Stream Name: #{stream_name}, Type: #{message.class.message_type}, Expected Version: #{expected_version.inspect})" }
      logger.trace(tags: [:data, :message]) { message.pretty_inspect }

      event_data = Message::Export.(message)

      event_writer.(event_data, stream_name, expected_version: expected_version).tap do
        logger.debug { "Wrote message (Stream Name: #{stream_name}, Type: #{message.class.message_type}, Expected Version: #{expected_version.inspect})" }
        logger.debug(tags: [:data, :message]) { message.pretty_inspect }
      end
    end
  end
end

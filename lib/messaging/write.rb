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
      def call(message, stream_name, expected_version: nil, reply_stream_name: nil, partition: nil, session: nil)
        instance = build(partition: partition, session: session)
        instance.(message, stream_name, expected_version: expected_version, reply_stream_name: reply_stream_name)
      end
    end

    def call(message, stream_name, expected_version: nil, reply_stream_name: nil)
      logger.trace { "Writing message (Stream Name: #{stream_name}, Type: #{message.class.message_type}, Expected Version: #{expected_version.inspect}, Reply Stream Name #{reply_stream_name.inspect})" }
      logger.trace(tags: [:data, :message]) { message.pretty_inspect }

      if reply_stream_name
         message.metadata.reply_stream_name = reply_stream_name
      end

      event_data = Message::Export.(message)

      event_writer.(event_data, stream_name, expected_version: expected_version).tap do
        logger.info { "Wrote message (Stream Name: #{stream_name}, Type: #{message.class.message_type}, Expected Version: #{expected_version.inspect}, Reply Stream Name #{reply_stream_name.inspect})" }
        logger.info(tags: [:data, :message]) { message.pretty_inspect }
        # telemetry.record :written, Telemetry::Data.new(written_message, stream_name, expected_version, reply_stream_name)
      end
    end
    alias :write :call

    def reply(message)
      metadata = message.metadata
      reply_stream_name = metadata.reply_stream_name

      logger.trace { "Replying (Message Type: #{message.message_type}, Stream Name: #{reply_stream_name})" }

      unless reply_stream_name
        error_msg = "Message has no reply stream name. Cannot reply. (Message Type: #{message.message_type})"
        logger.error { error_msg }
        raise Error, error_msg
      end

      metadata.clear_reply_stream_name

      write(message, reply_stream_name).tap do
        logger.info { "Replied (Message Type: #{message.message_type}, Stream Name: #{reply_stream_name})" }
        # telemetry.record :replied, Telemetry::Data.new(message, reply_stream_name)
      end
    end
  end
end

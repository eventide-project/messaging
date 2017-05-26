module Messaging
  module Write
    class Error < RuntimeError; end

    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        dependency :message_writer
        dependency :telemetry, ::Telemetry

        cls.extend Build
        cls.extend Call
        cls.extend Configure

        abstract :configure
      end
    end

    module Build
      def build(session: nil)
        instance = new
        instance.configure(session: session)
        ::Telemetry.configure instance
        instance
      end
    end

    module Configure
      def configure(receiver, session: nil, attr_name: nil)
        attr_name ||= :write
        instance = build(session: session)
        receiver.public_send "#{attr_name}=", instance
      end
    end

    module Call
      def call(message, stream_name, expected_version: nil, reply_stream_name: nil, session: nil)
        instance = build(session: session)
        instance.(message, stream_name, expected_version: expected_version, reply_stream_name: reply_stream_name)
      end
    end

    def call(message_or_batch, stream_name, expected_version: nil, reply_stream_name: nil)
      unless message_or_batch.is_a? Array
        logger.trace(tag: :write) { "Writing message (Stream Name: #{stream_name}, Type: #{message_or_batch.class.message_type}, Expected Version: #{expected_version.inspect}, Reply Stream Name: #{reply_stream_name.inspect})" }
      else
        logger.trace(tag: :write) { "Writing batch (Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect}, Reply Stream Name: #{reply_stream_name.inspect})" }
      end
      logger.trace(tags: [:write, :data, :message]) { message_or_batch.pretty_inspect }

      message_batch = Array(message_or_batch)

      message_data_batch = message_data_batch(message_batch, reply_stream_name)
      last_position = message_writer.(message_data_batch, stream_name, expected_version: expected_version)

      unless message_or_batch.is_a? Array
        logger.info(tag: :write) { "Wrote message (Position: #{last_position}, Stream Name: #{stream_name}, Type: #{message_or_batch.class.message_type}, Expected Version: #{expected_version.inspect}, Reply Stream Name: #{reply_stream_name.inspect})" }
      else
        logger.info(tag: :write) { "Wrote batch (Position: #{last_position}, Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect}, Reply Stream Name: #{reply_stream_name.inspect})" }
      end
      logger.info(tags: [:write, :data, :message]) { message_data_batch.pretty_inspect }

      message_batch.each do |message|
        telemetry.record :written, Telemetry::Data.new(message, stream_name, expected_version, reply_stream_name)
      end

      last_position
    end
    alias :write :call

    def message_data_batch(message_batch, reply_stream_name=nil)
      message_data_batch = []
      message_batch.each do |message|
        unless reply_stream_name.nil?
           message.metadata.reply_stream_name = reply_stream_name
        end

        message_data_batch << Message::Export.(message)
      end

      message_data_batch
    end

    def reply(message)
      if message.is_a? Array
        error_msg = "Cannot reply with a batch"
        logger.error { error_msg }
        raise Error, error_msg
      end

      metadata = message.metadata
      reply_stream_name = metadata.reply_stream_name

      logger.trace(tags: [:write, :reply]) { "Replying (Message Type: #{message.message_type}, Stream Name: #{reply_stream_name.inspect})" }

      if reply_stream_name.nil?
        error_msg = "Message has no reply stream name. Cannot reply. (Message Type: #{message.message_type})"
        logger.error { error_msg }
        logger.error(tags: [:data, :message]) { message.pretty_inspect }
        raise Error, error_msg
      end

      metadata.clear_reply_stream_name

      write(message, reply_stream_name).tap do
        logger.info(tags: [:write, :reply]) { "Replied (Message Type: #{message.message_type}, Stream Name: #{reply_stream_name})" }
        telemetry.record :replied, Telemetry::Data.new(message, reply_stream_name)
      end
    end

    def initial(message, stream_name)
      write(message, stream_name, expected_version: :no_stream)
    end
    alias :write_initial :initial

    def self.register_telemetry_sink(writer)
      sink = Telemetry.sink
      writer.telemetry.register sink
      sink
    end

    module Telemetry
      class Sink
        include ::Telemetry::Sink

        record :written
        record :replied
      end

      Data = Struct.new :message, :stream_name, :expected_version, :reply_stream_name

      def self.sink
        Sink.new
      end
    end
  end
end

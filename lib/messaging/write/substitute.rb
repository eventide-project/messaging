module Messaging
  module Write
    module Substitute
      def self.build
        Substitute::Write.build.tap do |substitute_writer|
          sink = Messaging::Write.register_telemetry_sink(substitute_writer)
          substitute_writer.sink = sink
        end
      end

      class Write
        Error = Class.new(RuntimeError)

        include Messaging::Write

        attr_accessor :sink

        def self.build(session: nil)
          new.tap do |instance|
            ::Telemetry.configure instance
          end
        end

        def writes(&blk)
          if blk.nil?
            return sink.written_records
          end

          sink.written_records.select do |record|
            blk.call(record.data.message, record.data.stream_name, record.data.expected_version, record.data.reply_stream_name)
          end
        end

        def written?(message=nil, &blk)
          if message.nil?
            if blk.nil?
              return sink.recorded_written?
            end

            return sink.recorded_written? do |record|
              blk.call(record.data.message, record.data.stream_name, record.data.expected_version, record.data.reply_stream_name)
            end
          end

          written = sink.recorded_written? do |record|
            record.data.message == message
          end

          if blk.nil?
            return written
          end

          sink.recorded_written? do |record|
            blk.call(record.data.stream_name, record.data.expected_version, record.data.reply_stream_name)
          end
        end

        def replies(&blk)
          if blk.nil?
            return sink.replied_records
          end

          sink.replied_records.select do |record|
            blk.call(record.data.message, record.data.stream_name)
          end
        end

        def replied?(message=nil, &blk)
          if message.nil?
            if blk.nil?
              return sink.recorded_replied?
            end

            return sink.recorded_replied? do |record|
              blk.call(record.data.message, record.data.stream_name)
            end
          end

          written = sink.recorded_replied? do |record|
            record.data.message == message
          end

          if blk.nil?
            return written
          end

          sink.recorded_replied? do |record|
            blk.call(record.data.stream_name)
          end
        end

        def message_writes(&blk)
          if blk.nil?
            return sink.written_records.map { |record| record.data.message }
          end

          sink.written_records.select do |record|
            blk.call(record.data.message, record.data.stream_name, record.data.expected_version, record.data.reply_stream_name)
          end.map { |record| record.data.message }
        end
        alias :messages :message_writes

        def one_message_write(&blk)
          messages = message_writes(&blk)

          if messages.length > 1
            raise Error, "More than one matching message was written"
          end

          messages.first
        end
        alias :message :one_message_write
        alias :one_message :one_message_write

        def message_replies(&blk)
          if blk.nil?
            return sink.replied_records.map { |record| record.data.message }
          end

          sink.replied_records.select do |record|
            blk.call(record.data.message, record.data.stream_name)
          end.map { |record| record.data.message }
        end
        alias :replies :message_replies
      end
    end
  end
end

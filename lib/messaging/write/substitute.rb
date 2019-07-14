module Messaging
  module Write
    module Substitute
      def self.build
        Substitute::Write.build.tap do |substitute_writer|
          sink = Messaging::Write.register_telemetry_sink(substitute_writer)
          substitute_writer.sink = sink
        end
      end

      Error = Class.new(RuntimeError)

      class Write
        include Messaging::Write

        attr_accessor :sink

        def raise_expected_version_error
          @raise_expected_version_error ||= false
        end
        attr_writer :raise_expected_version_error

        def self.build(session: nil)
          new.tap do |instance|
            ::Telemetry.configure instance
          end
        end

        def call(*args, **keyword_args)
          raise MessageStore::ExpectedVersion::Error if raise_expected_version_error
          super(*args, **keyword_args)
        end
        alias :write :call

        def raise_expected_version_error!
          self.raise_expected_version_error = true
          nil
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

          if !written
            return false
          end

          # Is written and no inspection block is provided,
          # therefore no subsequent inspection beyond the
          # message being found in the telemetry
          # Is written
          if blk.nil?
            return true
          end

          # Otherwise, proceed to subsequent inspecting using the block
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

          if !written
            return false
          end

          # Is written and no inspection block is provided,
          # therefore no subsequent inspection beyond the
          # message being found in the telemetry
          # Is written
          if blk.nil?
            return true
          end

          # Otherwise, proceed to subsequent inspecting using the block
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

        def one_message_write(&blk)
          messages = message_writes(&blk)

          if messages.length > 1
            raise Substitute::Error, "More than one matching message was written"
          end

          messages.first
        end
        alias :one_message :one_message_write

        def message_replies(&blk)
          if blk.nil?
            return sink.replied_records.map { |record| record.data.message }
          end

          sink.replied_records.select do |record|
            blk.call(record.data.message, record.data.stream_name)
          end.map { |record| record.data.message }
        end

        def one_message_reply(&blk)
          messages = message_replies(&blk)

          if messages.length > 1
            raise Substitute::Error, "More than one matching message reply was written"
          end

          messages.first
        end
        alias :one_reply :one_message_reply
      end
    end
  end
end

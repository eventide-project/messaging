module Messaging
  module Controls
    module Metadata
      def self.example
        Messaging::Message::Metadata.build(data)
      end

      def self.source_message_stream_name
        'someSource'
      end

      def self.source_message_position
        1
      end

      def self.causation_message_stream_name
        "someCausation"
      end

      def self.causation_message_position
        11
      end

      def self.correlation_stream_name
        "someCorrelation"
      end

      def self.reply_stream_name
        "someReply"
      end

      def self.schema_version
        '1.1'
      end

      def self.source_message_identifier
        "#{source_message_stream_name}/#{source_message_position}"
      end

      def self.causation_message_identifier
        "#{causation_message_stream_name}/#{causation_message_position}"
      end

      def self.global_position
        111
      end

      def self.time
        Time::Raw.example
      end

      def self.data
        {
          source_message_stream_name: source_message_stream_name,
          source_message_position: source_message_position,

          causation_message_stream_name: causation_message_stream_name,
          causation_message_position: causation_message_position,

          correlation_stream_name: correlation_stream_name,

          reply_stream_name: reply_stream_name,

          global_position: global_position,
          time: time,

          schema_version: schema_version
        }
      end

      module New
        def self.example
          ::Messaging::Message::Metadata.new
        end
      end
      Empty = New

      module Written
        def self.example
          Messaging::Message::Metadata.build(data)
        end

        def self.data
          data = Metadata.data

          Messaging::Message::Metadata.transient_attributes.each do |not_written_attribute|
            data.delete(not_written_attribute)
          end

          data
        end
      end
    end
  end
end

module Messaging
  module Controls
    module Metadata
      def self.example
        Messaging::Message::Metadata.build(data)
      end

      def self.source_event_stream_name
        'someSource'
      end

      def self.source_event_position
        1
      end

      def self.causation_event_stream_name
        "someCausation"
      end

      def self.causation_event_position
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

      def self.source_event_identifier
        "#{source_event_stream_name}/#{source_event_position}"
      end

      def self.causation_event_identifier
        "#{causation_event_stream_name}/#{causation_event_position}"
      end

      def self.global_position
        111
      end

      def self.time
        Time::Raw.example
      end

      def self.data
        {
          source_event_stream_name: source_event_stream_name,
          source_event_position: source_event_position,

          causation_event_stream_name: causation_event_stream_name,
          causation_event_position: causation_event_position,

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

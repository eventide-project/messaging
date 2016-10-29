module Messaging
  module Controls
    module Metadata
      def self.example
        Messaging::Message::Metadata.build data
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
        11
      end

      def self.source_event_identifier
        "#{source_event_stream_name}/#{source_event_position}"
      end

      def self.causation_event_identifier
        "#{causation_event_stream_name}/#{causation_event_position}"
      end

      def self.data
        {
          source_event_stream_name: source_event_stream_name,
          source_event_position: source_event_position,

          causation_event_stream_name: causation_event_stream_name,
          causation_event_position: causation_event_position,

          correlation_stream_name: correlation_stream_name,

          reply_stream_name: reply_stream_name,

          schema_version: schema_version
        }
      end

      module New
        def self.example
          ::Messaging::Message::Metadata.new
        end
      end
      Empty = New

      module Read
        def self.example
          Messaging::Message::Metadata.build data
        end

        def self.data
          data = Metadata.data

          data.delete(:source_event_stream_name)
          data.delete(:source_event_position)

          data
        end
      end
    end
  end
end

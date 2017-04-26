module Messaging
  module Message
    class Metadata
      class Error < RuntimeError; end

      include Schema::DataStructure

      attribute :source_event_stream_name, String
      alias :stream_name :source_event_stream_name
      attribute :source_event_position, Integer
      alias :sequence :source_event_position
      alias :position :source_event_position
      alias :position= :source_event_position=

      attribute :causation_event_stream_name, String
      attribute :causation_event_position, Integer

      attribute :correlation_stream_name, String

      attribute :reply_stream_name, String

      attribute :global_position, Integer
      attribute :time, Time

      attribute :schema_version, String

      def source_event_identifier
        return nil if source_event_stream_name.nil? || source_event_position.nil?
        "#{source_event_stream_name}/#{source_event_position}"
      end

      def causation_event_identifier
        return nil if causation_event_stream_name.nil? || causation_event_position.nil?
        "#{causation_event_stream_name}/#{causation_event_position}"
      end

      def follow(other_metadata)
        self.causation_event_stream_name = other_metadata.source_event_stream_name
        self.causation_event_position = other_metadata.source_event_position

        self.correlation_stream_name = other_metadata.correlation_stream_name

        self.reply_stream_name = other_metadata.reply_stream_name
      end

      def follows?(other_metadata)
        causation_event_identifier == other_metadata.source_event_identifier &&
          correlation_stream_name == other_metadata.correlation_stream_name &&
          reply_stream_name == other_metadata.reply_stream_name
      end

      def clear_reply_stream_name
        self.reply_stream_name = nil
      end

      def self.transient_attributes
        [
          :source_event_stream_name,
          :source_event_position,
          :global_position,
          :time
        ]
      end
    end
  end
end

module Messaging
  module Message
    class Metadata
      class Error < RuntimeError; end

      include Schema::DataStructure

      attribute :source_event_stream_name
      attribute :source_event_position
      alias :position :source_event_position

      attribute :causation_event_stream_name
      attribute :causation_event_position

      attribute :correlation_stream_name

      attribute :reply_stream_name

      attribute :schema_version

      def source_event_identifier
        "#{source_event_stream_name}/#{source_event_position}"
      end

      def causation_event_identifier
        "#{causation_event_stream_name}/#{causation_event_position}"
      end

      def follow(other_metadata)
        self.causation_event_stream_name = other_metadata.source_event_stream_name
        self.causation_event_position = other_metadata.source_event_position

        unless follows?(other_metadata)
          raise Error, "Metadata doesn't have precedence (Metadata: #{self}, Other Metadata #{other_metadata})"
        end
      end

      def follows?(other_metadata)
        causation_event_identifier == other_metadata.source_event_identifier &&

          correlation_stream_name == other_metadata.correlation_stream_name &&
          reply_stream_name == other_metadata.reply_stream_name
      end
      alias :precedence? :follows?

      def clear_reply_stream_name
        self.reply_stream_name = nil
      end
    end
  end
end

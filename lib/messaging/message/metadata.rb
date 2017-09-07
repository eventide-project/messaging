module Messaging
  module Message
    class Metadata
      class Error < RuntimeError; end

      include Schema::DataStructure

      attribute :stream_name, String
      alias :source_message_stream_name :stream_name
      alias :source_message_stream_name= :stream_name=

      attribute :position, Integer
      alias :source_message_position :position
      alias :source_message_position= :position=

      attribute :global_position, Integer
      alias :source_message_global_position :global_position
      alias :source_message_global_position= :global_position=

      attribute :causation_message_stream_name, String
      attribute :causation_message_position, Integer
      attribute :causation_message_global_position, Integer
      alias :sequence :causation_message_global_position
      alias :sequence= :causation_message_global_position=

      attribute :correlation_stream_name, String

      attribute :reply_stream_name, String

      attribute :time, Time

      attribute :schema_version, String

      def source_message_identifier
        return nil if stream_name.nil? || position.nil?
        "#{stream_name}/#{position}"
      end

      def causation_message_identifier
        return nil if causation_message_stream_name.nil? || causation_message_position.nil?
        "#{causation_message_stream_name}/#{causation_message_position}"
      end

      def follow(other_metadata)
        self.causation_message_stream_name = other_metadata.stream_name
        self.causation_message_position = other_metadata.position
        self.causation_message_global_position = other_metadata.global_position

        self.correlation_stream_name = other_metadata.correlation_stream_name

        self.reply_stream_name = other_metadata.reply_stream_name
      end

      def follows?(other_metadata)
        causation_message_identifier == other_metadata.source_message_identifier &&
          causation_message_global_position == other_metadata.global_position &&
          correlation_stream_name == other_metadata.correlation_stream_name &&
          reply_stream_name == other_metadata.reply_stream_name
      end

      def clear_reply_stream_name
        self.reply_stream_name = nil
      end

      def reply?
        !reply_stream_name.nil?
      end

      def correlated?(stream_name)
        correlation_stream_name = self.correlation_stream_name

        stream_name = Category.normalize(stream_name)

        if MessageStore::StreamName.category?(stream_name)
          correlation_stream_name = MessageStore::StreamName.get_category(correlation_stream_name)
        end

        correlation_stream_name == stream_name
      end
      alias :correlates? :correlated?

      def self.transient_attributes
        [
          :stream_name,
          :position,
          :global_position,
          :time
        ]
      end
    end
  end
end

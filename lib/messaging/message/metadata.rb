module Messaging
  module Message
    class Metadata
      include Schema::DataStructure

      attribute :source_event_authority
      attribute :source_event_stream_name
      attribute :source_event_position
      alias :position :source_event_position

      attribute :causation_event_authority
      attribute :causation_event_stream_name
      attribute :causation_event_position

      attribute :correlation_event_authority
      attribute :correlation_event_stream_name
      attribute :correlation_event_position

      attribute :reply_stream_name

      attribute :schema_version

      def source_event_identifier
        identifier(:source)
      end

      def causation_event_identifier
        identifier(:causation)
      end

      def correlation_event_identifier
        identifier(:correlation)
      end

      def identifier(type)
        authority = public_send("#{type}_event_stream_name")
        stream_name = public_send("#{type}_event_stream_name")
        position = public_send("#{type}_event_position")

        identifier = "#{stream_name}/#{position}"

        unless authority.nil?
          identifier = "#{authority}/#{identifier}"
        end

        identifier
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

module Messaging
  module Message
    module Follow
      class Error < RuntimeError; end

      extend self

      def self.call(source, receiver=nil, copy: nil, include: nil, exclude: nil, strict: nil)
        follow(source, receiver, copy: copy, include: include, exclude: exclude, strict: strict)
      end

      def follow(source, receiver=nil, copy: nil, include: nil, exclude: nil, strict: nil)
        unchanged_source_event_stream_name = receiver.metadata.source_event_stream_name
        unchanged_source_event_position = receiver.metadata.source_event_position

        Copy.(source, receiver, copy: copy, include: include, exclude: exclude, strict: strict, metadata: true)

        receiver.metadata.source_event_stream_name = unchanged_source_event_stream_name
        receiver.metadata.source_event_position = unchanged_source_event_position

        receiver.metadata.follow(source.metadata)

        receiver
      end
    end
  end
end

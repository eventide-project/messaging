module Messaging
  module Message
    module Follow
      extend self

      def self.call(preceding_message, subsequent_message=nil, copy: nil, include: nil, exclude: nil, strict: nil)
        follow(preceding_message, subsequent_message, copy: copy, include: include, exclude: exclude, strict: strict)
      end

      def follow(preceding_message, subsequent_message=nil, copy: nil, include: nil, exclude: nil, strict: nil)
        if subsequent_message.nil?
          subsequent_message = self
        end

        if subsequent_message.class == Class
          subsequent_message = subsequent_message.build
        end

        strict = true if strict.nil?

        Copy.(preceding_message, subsequent_message, copy: copy, include: include, exclude: exclude, strict: strict, metadata: false)

        subsequent_message.metadata.follow(preceding_message.metadata)

        subsequent_message
      end
    end
  end
end

module Messaging
  module Message
    module Follow
      extend self

      def self.call(source, receiver=nil, copy: nil, include: nil, exclude: nil, strict: nil)
        follow(source, receiver, copy: copy, include: include, exclude: exclude, strict: strict)
      end

      def follow(source, receiver=nil, copy: nil, include: nil, exclude: nil, strict: nil)
        if receiver.nil?
          receiver = self
        end

        if receiver.class == Class
          receiver = receiver.build
        end

        Copy.(source, receiver, copy: copy, include: include, exclude: exclude, strict: strict, metadata: false)

        receiver.metadata.follow(source.metadata)

        receiver
      end
    end
  end
end

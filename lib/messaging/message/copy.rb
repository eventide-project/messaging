module Messaging
  module Message
    module Copy
      class Error < RuntimeError; end

      extend self

      def self.call(source, receiver=nil, copy: nil, include: nil, exclude: nil, metadata: nil, strict: nil)
        copy(source, receiver, copy: copy, include: include, exclude: exclude, metadata: metadata, strict: strict)
      end

      def copy(source, receiver=nil, copy: nil, include: nil, exclude: nil, metadata: nil, strict: nil)
        metadata ||= false
        strict = true if strict.nil?

        if receiver.nil?
          receiver = self
        end

        if receiver.class == Class
          receiver = receiver.build
        end

        begin
          SetAttributes.(receiver, source, copy: copy, include: include, exclude: exclude, strict: strict)
        rescue SetAttributes::Attribute::Error => e
          raise Error, e.message, e.backtrace
        end

        if metadata
          SetAttributes.(receiver.metadata, source.metadata)
        end

        receiver
      end
    end
  end
end

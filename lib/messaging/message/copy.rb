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
        strict ||= false

        if receiver.nil?
          receiver = self
        end

        if receiver.class == Class
          receiver = receiver.build
        end

        if copy.nil? && include.nil?
          include = source.class.attribute_names
        end

        begin
          SetAttributes.(receiver, source, copy: copy, include: include, exclude: exclude, strict: strict)
        rescue SetAttributes::Assign::Error => e
          raise Error, e.message, e.backtrace
        end

        if metadata
          metadata_include = source.metadata.class.attribute_names - [:properties, :local_properties]

          SetAttributes.(receiver.metadata, source.metadata, include: metadata_include)

          receiver.metadata.properties = source.metadata.properties.dup
          receiver.metadata.local_properties = source.metadata.local_properties.dup
        end

        receiver
      end
    end
  end
end

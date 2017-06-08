module Messaging
  module Message
    def self.included(cls)
      cls.class_exec do
        include Schema::DataStructure

        extend Info
        extend Build
        extend Copy
        extend Follow
        extend Correlate
        extend Transformer

        attribute :id, String
        attribute :metadata, Metadata, default: -> { Metadata.new }

        def self.transient_attributes
          [
            :id,
            :metadata
          ]
        end
      end
    end

    def message_type
      self.class.message_type
    end

    def message_name
      self.class.message_name
    end

    def follows?(other_message)
      metadata.follows?(other_message.metadata)
    end

    module Info
      extend self

      def message_type(msg=self)
        class_name(msg).split('::').last
      end

      def message_type?(type)
        message_type == type
      end

      def message_name(msg=self)
        Info.canonize_name(message_type(msg))
      end

      def self.canonize_name(name)
        name.gsub(/([^\^])([A-Z])/,'\1_\2').downcase
      end

      def class_name(message)
        class_name = nil
        class_name = message if message.instance_of? String
        class_name ||= message.name if message.instance_of? Class
        class_name ||= message.class.name
        class_name
      end
    end

    module Build
      def build(data=nil, metadata=nil)
        data ||= {}
        metadata ||= {}

        metadata = build_metadata(metadata)

        new.tap do |instance|
          set_attributes(instance, data)
          instance.metadata = metadata
        end
      end

      def set_attributes(instance, data)
        SetAttributes.(instance, data)
      end

      def build_metadata(metadata)
        if metadata.nil?
          Metadata.new
        else
          Metadata.build(metadata.to_h)
        end
      end
    end

    module Correlate
      def correlate(correlation_stream_name)
        instance = build
        instance.metadata.correlation_stream_name = correlation_stream_name
        instance
      end
    end
  end
end

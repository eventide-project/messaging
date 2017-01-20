module Messaging
  module Message
    def self.included(cls)
      cls.class_exec do
        include Schema::DataStructure

        attribute :id, String

        def self.transient_attributes
          [
            :id
          ]
        end
      end

      ## TODO put this in the included block, and remove the cls.
      cls.extend Info
      cls.extend Build
      cls.extend Copy
      cls.extend Follow
      cls.extend Transformer
    end

    attr_writer :metadata
    def metadata
      @metadata ||= Metadata.new
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
  end
end

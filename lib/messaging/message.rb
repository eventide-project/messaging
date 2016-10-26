module Messaging
  module Message
    def self.included(cls)
      cls.class_exec do
        include Schema::DataStructure
      end

      cls.extend Info
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

    module Info
      extend self

      def message_type(msg=self)
        class_name(msg).split('::').last
      end

      def message_name(msg=self)
        message_type(msg).gsub(/([^\^])([A-Z])/,'\1_\2').downcase
      end

      def class_name(message)
        class_name = nil
        class_name = message if message.instance_of? String
        class_name ||= message.name if message.instance_of? Class
        class_name ||= message.class.name
        class_name
      end
    end
  end
end

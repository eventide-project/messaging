module Messaging
  module Postgres
    module StreamName
      def self.included(cls)
        cls.class_exec do
          include Messaging::StreamName
        end
      end

      extend self
      extend Messaging::StreamName

      def category_stream_name(category=nil)
        category ||= self.category
        category
      end

      def command_category_stream_name(category=nil)
        category ||= self.category
        EventSource::StreamName.stream_name category, type: 'command'
      end
    end
  end
end

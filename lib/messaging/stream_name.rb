module Messaging
  module StreamName
    extend self

    def self.included(cls)
      cls.class_exec do
        include Messaging::Category
      end
    end

    def stream_name(id, category=nil, type: nil)
      category ||= self.category
      MessageStore::StreamName.stream_name(category, id, type: type)
    end

    def category_stream_name(category=nil)
      category ||= self.category
      category
    end

    def command_stream_name(id, category=nil)
      category ||= self.category
      MessageStore::StreamName.stream_name(category, id, type: 'command')
    end

    def command_category_stream_name(category=nil)
      category ||= self.category
      MessageStore::StreamName.stream_name(category, type: 'command')
    end

    def self.get_category(stream_name)
      MessageStore::StreamName.get_category(stream_name)
    end

    def self.get_id(stream_name)
      MessageStore::StreamName.get_id stream_name
    end
  end
end

module Messaging
  module StreamName
    extend self

    Error = Class.new(RuntimeError)

    def self.included(cls)
      cls.class_exec do
        include Virtual
        include Messaging::Category

        virtual :category
      end
    end

    def stream_name(stream_id=nil, stream_category=nil, category: nil, cardinal_id: nil, id: nil, ids: nil, type: nil, types: nil)
      if stream_id.nil? && cardinal_id.nil? && id.nil? && ids.nil?
        raise Error, "ID must not be omitted from stream name"
      end

      stream_category ||= category
      if stream_category.nil?
        if not self.respond_to?(:category)
          raise Error, "Category must not be omitted from stream name"
        else
          stream_category = self.category
        end
      end

      MessageStore::StreamName.stream_name(stream_category, stream_id, cardinal_id: cardinal_id, id: id, ids: ids, type: type, types: types)
    end

    def category_stream_name(category=nil, type: nil, types: nil)
      category ||= self.category
      MessageStore::StreamName.stream_name(category, type: type, types: types)
    end

    def command_stream_name(id, category=nil, type: nil, types: nil)
      if id == nil
        raise Error, "ID must not be omitted from command stream name"
      end

      category ||= self.category
      types ||= []
      types.unshift('command')
      types << type unless type == nil
      MessageStore::StreamName.stream_name(category, id, types: types)
    end

    def command_category_stream_name(category=nil, type: nil, types: nil)
      category ||= self.category
      types ||= []
      types.unshift('command')
      types << type unless type == nil
      MessageStore::StreamName.stream_name(category, types: types)
    end

    def self.get_category(stream_name)
      MessageStore::StreamName.get_category(stream_name)
    end

    def self.category?(stream_name)
      MessageStore::StreamName.category?(stream_name)
    end

    def self.get_entity_name(stream_name)
      MessageStore::StreamName.get_entity_name(stream_name)
    end

    def self.get_id(stream_name)
      MessageStore::StreamName.get_id(stream_name)
    end

    def self.get_ids(stream_name)
      MessageStore::StreamName.get_ids(stream_name)
    end

    def self.get_cardinal_id(stream_name)
      MessageStore::StreamName.get_cardinal_id(stream_name)
    end

    def self.get_type(stream_name)
      MessageStore::StreamName.get_type(stream_name)
    end

    def self.get_types(stream_name)
      MessageStore::StreamName.get_types(stream_name)
    end
  end
end

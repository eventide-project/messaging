module Messaging
  module StreamName
    extend self

    include EventSource::StreamName

    def self.included(cls)
      cls.extend Macro
    end

    def self.activate
      target_class ||= Object
      macro_module = Macro
      return if target_class.is_a? macro_module
      target_class.extend(macro_module)
    end

    module Macro
      def category_macro(category_name)
        category_name = Casing::Camel.(category_name, symbol_to_string: true)
        self.send :define_method, :category_name do
          @category_name || category_name
        end
      end
      alias :category :category_macro
    end

    def stream_name(id, category_name=nil)
      category_name ||= self.category_name
      EventSource::StreamName.stream_name category_name, id
    end

    def command_stream_name(id, category_name=nil)
      category_name ||= self.category_name
      EventSource::StreamName.stream_name "#{category_name}:command", id
    end

    def category_stream_name(category_name=nil)
      category_name ||= self.category_name
      category_name
    end

    def command_category_stream_name(category_name=nil)
      category_name ||= self.category_name
      category_stream_name = category_stream_name(category_name)

      "#{category_stream_name}:command"
    end

    def self.get_category(stream_name)
      stream_name.split('-')[0]
    end

    def self.get_id(stream_name)
      EventSource::StreamName.get_id stream_name
    end
  end
end

module Messaging
  module Controls
    module Properties
      def self.example
        [
          SomeProperty.example,
          SomeTransientProperty.example
        ]
      end

      def self.data
        [
          SomeProperty.data,
          SomeTransientProperty.data
        ]
      end

      module SomeProperty
        def self.example
          Messaging::Message::Metadata::Property.new(name, value)
        end

        def self.data
          {
            name: name,
            value: value
          }
        end

        def self.name
          :some_property
        end

        def self.value
          'some property value'
        end
      end

      module SomeTransientProperty
        def self.example
          Messaging::Message::Metadata::Property.new(name, value, true)
        end

        def self.data
          {
            name: name,
            value: value,
            transient: true
          }
        end

        def self.name
          :some_transient_property
        end

        def self.value
          'some transient property value'
        end
      end
    end
  end
end

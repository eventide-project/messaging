module Messaging
  module Controls
    module Properties
      def self.example
        [
          SomeProperty.example,
          SomeLocalProperty.example
        ]
      end

      def self.data
        [
          SomeProperty.data,
          SomeLocalProperty.data
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
          'some_property'
        end

        def self.value
          'some property value'
        end
      end

      module SomeLocalProperty
        def self.example
          Messaging::Message::Metadata::Property.new(name, value, true)
        end

        def self.data
          {
            name: name,
            value: value,
            local: true
          }
        end

        def self.name
          'some_local_property'
        end

        def self.value
          'some local property value'
        end
      end

      module Random
        def self.example
          [
            SomeProperty.example,
            SomeLocalProperty.example
          ]
        end

        def self.data
          [
            SomeProperty.data,
            SomeLocalProperty.data
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
            'some_property'
          end

          def self.value
            SecureRandom.hex
          end
        end

        module SomeLocalProperty
          def self.example
            Messaging::Message::Metadata::Property.new(name, value, true)
          end

          def self.data
            {
              name: name,
              value: value,
              local: true
            }
          end

          def self.name
            'some_local_property'
          end

          def self.value
            SecureRandom.hex
          end
        end
      end
    end
  end
end

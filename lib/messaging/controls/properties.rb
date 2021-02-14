module Messaging
  module Controls
    module Properties
      def self.example
        {
          SomeProperty.name => SomeProperty.example,
          SomeLocalProperty.name => SomeLocalProperty.example
        }
      end

      def self.data
        {
          SomeProperty.name => SomeProperty.data,
          SomeLocalProperty.name => SomeLocalProperty.data
        }
      end

      module SomeProperty
        def self.example
          Messaging::Message::Metadata::Property.new(value)
        end

        def self.data
          {
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

      module SomeLocalProperty
        def self.example
          Messaging::Message::Metadata::Property.new(value, true)
        end

        def self.data
          {
            value: value,
            local: true
          }
        end

        def self.name
          :some_local_property
        end

        def self.value
          'some local property value'
        end
      end

      module Random
        def self.example
          {
            SomeProperty.name => SomeProperty.example,
            SomeLocalProperty.name => SomeLocalProperty.example
          }
        end

        def self.data
          {
            SomeProperty.name => SomeProperty.data,
            SomeLocalProperty.name => SomeLocalProperty.data
          }
        end

        module SomeProperty
          def self.example
            Messaging::Message::Metadata::Property.new(name, value)
          end

          def self.data
            {
              value: value
            }
          end

          def self.name
            :some_property
          end

          def self.value
            SecureRandom.hex
          end
        end

        module SomeLocalProperty
          def self.example
            Messaging::Message::Metadata::Property.new(value, true)
          end

          def self.data
            {
              value: value,
              local: true
            }
          end

          def self.name
            :some_local_property
          end

          def self.value
            SecureRandom.hex
          end
        end
      end
    end
  end
end

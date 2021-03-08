module Messaging
  module Controls
    module LocalProperties
      def self.example
        {
          SomeLocalProperty.name => SomeLocalProperty.value
        }
      end

      module SomeLocalProperty
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
            SomeLocalProperty.name => SomeLocalProperty.value
          }
        end

        module SomeLocalProperty
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

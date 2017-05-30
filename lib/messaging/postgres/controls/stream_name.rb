module Messaging
  module Postgres
    module Controls
      StreamName = MessageStore::Postgres::Controls::StreamName

      module StreamName
        module Named
          def self.example
            Example.new
          end

          class Example
            include Messaging::Postgres::StreamName

            category :some_category
          end
        end
      end
    end
  end
end

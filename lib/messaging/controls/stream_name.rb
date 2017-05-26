module Messaging
  module Controls
    StreamName = MessageStore::Controls::StreamName

    module StreamName
      module Named
        def self.example
          Example.new
        end

        class Example
          include Messaging::StreamName

          category :some_category
        end
      end
    end
  end
end

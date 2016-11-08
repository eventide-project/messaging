module Messaging
  module Controls
    module Handler
      module EventData
        class Example
          include Messaging::Handle

          def handle(event_data)
            event_data.data = EventData.data
          end
        end

        def self.data
          'some value set by handler'
        end
      end

      module Message
        class Example
          include Messaging::Handle

          def handle_some_message(some_message)
            some_message.some_attribute = Message.attribute
          end
        end

        def self.attribute
          'some value set by handler'
        end
      end

      module NoHandle
        class Example
          include Messaging::Handle
        end
      end
    end
  end
end

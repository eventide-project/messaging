module Messaging
  module Controls
    module Handler
      class Example
        include Messaging::Handle
        include Controls::Message

        handle SomeMessage do |some_message|
          some_message.some_attribute = 'some value set by handler'
        end
      end

      module HandleMethod
        class Example
          include Messaging::Handle

          def handle(message_data)
            message_data.data = 'some value set by handle method'
          end
        end
      end

      module BlockAndHandleMethod
        class Example
          include Messaging::Handle
          include Controls::Message

          handle SomeMessage do |some_message|
            some_message.some_attribute = 'some attribute value set by handler'
          end

          def handle(message_data)
            message_data.data = 'some data value set by handler'
          end
        end
      end

      module Anomaly
        module NoHandle
          class Example
            include Messaging::Handle
          end
        end
      end
    end
  end
end

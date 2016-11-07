module Messaging
  module Controls
    module Handler
      def self.example
        Example.build
      end

      class Example
        include Messaging::Handle

        def handle(event_data)
          event_data.data = 'some value'
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

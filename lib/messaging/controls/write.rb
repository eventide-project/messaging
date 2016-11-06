module Messaging
  module Controls
    module Write
      def self.example
        Example.build
      end

      class Example
        include Messaging::Write

        def configure(partition: nil, session: nil)
        end
      end
    end
  end
end

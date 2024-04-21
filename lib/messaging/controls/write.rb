module Messaging
  module Controls
    module Write
      def self.example
        Example.build
      end

      class Example
        include Messaging::Write

        def configure(*)
        end
      end
    end
  end
end

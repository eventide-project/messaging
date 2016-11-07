module Messaging
  module Controls
    module Write
      def self.example
        Example.build
      end

      class Example
        include Messaging::Write

        virtual :configure
      end
    end
  end
end

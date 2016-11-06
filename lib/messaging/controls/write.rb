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

      module Substitute
        def self.example
          raise NotImplementedError, "TODO: Need control that returns substitute writer"
        end
      end
    end
  end
end

module Messaging
  module Controls
    module Write
      def self.example
        Example.build
      end

      class Example
        include Messaging::Write

        virtual :configure
        # def configure(partition: nil, session: nil)
        # end
      end

      module Substitute
        def self.example
          ## control that returns substitute writer
        end
      end
    end
  end
end

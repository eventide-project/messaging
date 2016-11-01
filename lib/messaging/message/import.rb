module Messaging
  module Message
    module Import
      def self.call(event_data, message_class)
        Transform::Read.(event_data, :event_data, message_class)
      end
    end
  end
end

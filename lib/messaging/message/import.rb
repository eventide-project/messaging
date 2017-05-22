module Messaging
  module Message
    module Import
      def self.call(message_data, message_class)
        Transform::Read.(message_data, :message_data, message_class)
      end
    end
  end
end

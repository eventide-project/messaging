module Messaging
  module Message
    module Export
      def self.call(message)
        Transform::Write.(message, :event_data)
      end
    end
  end
end

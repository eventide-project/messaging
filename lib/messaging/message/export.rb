module Messaging
  module Message
    module Export
      def self.call(event_data)
        Transform::Write.(event_data, :event_data)
      end
    end
  end
end

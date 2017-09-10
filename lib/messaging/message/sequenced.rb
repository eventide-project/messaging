module Messaging
  module Message
    module Sequenced
      def self.included(cls)
        cls.class_exec do
          include Messaging::Message
          include Messaging::Message::SequenceAccessor
        end
      end
    end
  end
end

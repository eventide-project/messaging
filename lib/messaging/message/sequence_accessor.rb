module Messaging
  module Message
    module SequenceAccessor
      def sequence
        metadata.causation_message_global_position
      end

      def sequence=(val)
        metadata.causation_message_global_position = val
      end
    end
  end
end

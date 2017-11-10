module Messaging
  module Message
    module SequenceAccessor
      def sequence
        metadata.global_position
      end
    end
  end
end

module Messaging
  module Message
    module Command
      module SequenceAccessor
        def sequence
          metadata.global_position
        end
      end
    end
  end
end

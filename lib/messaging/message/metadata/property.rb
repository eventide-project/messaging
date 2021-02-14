module Messaging
  module Message
    class Metadata
      Property = Struct.new(
        :value,
        :local
      ) do
        def local?
          local == true
        end

        def ==(other)
          equal =
            value == other.value &&
            !!local == !!other.local
        end
      end
    end
  end
end

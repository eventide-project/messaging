module Messaging
  module Message
    class Metadata
      Property = Struct.new(
        :name,
        :value,
        :local
      ) do
        def local?
          local == true
        end

        def ==(other)
          equal =
            name == other.name &&
            value == other.value &&
            !!local == !!other.local
        end
      end
    end
  end
end

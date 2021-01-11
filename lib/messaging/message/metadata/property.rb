module Messaging
  module Message
    class Metadata
      Property = Struct.new(
        :name,
        :value,
        :transient
      ) do
        def transient?
          transient == true
        end

        def ==(other)
          equal =
            name == other.name &&
            value == other.value &&
            !!transient == !!other.transient
        end
      end
    end
  end
end

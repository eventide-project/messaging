module Messaging
  module Controls
    module Random
      module Number
        def self.example
          rand(99999)
        end
      end

      module Text
        def self.example
          SecureRandom.hex
        end
      end
    end
  end
end

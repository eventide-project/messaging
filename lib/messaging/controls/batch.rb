module Messaging
  module Controls
    module Batch
      def self.example(id: nil)
        if id == :none
          id = nil
        else
          id ||= self.id
        end

        values = [
          MessageStore::Controls::RandomValue.example,
          MessageStore::Controls::RandomValue.example
        ]

        batch = Messages.example(id: id)

        2.times do |i|
          batch[i].some_attribute = values[i]
        end

        return batch, values
      end

      def self.id
        ID::Random.example
      end

      module Messages
        def self.example(id: nil)
          [
            Controls::Message.example.tap { |m| m.id = id },
            Controls::Message.example.tap { |m| m.id = id }
          ]
        end
      end
    end
  end
end

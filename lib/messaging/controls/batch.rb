module Messaging
  module Controls
    module Batch
      def self.example(id: nil)
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
          batch = []

          2.times do
            message_id = nil
            if id != :none
              message_id = Batch.id
            end

            batch << Controls::Message.example.tap { |m| m.id = message_id }
          end

          batch
        end
      end
    end
  end
end

module Messaging
  module Postgres
    module Controls
      module Batch
        def self.example
          values = [
            EventSource::Controls::RandomValue.example,
            EventSource::Controls::RandomValue.example
          ]

          batch = Messages.example

          2.times do |i|
            batch[i].some_attribute = values[i]
          end

          return batch, values
        end

        module Messages
          def self.example
            [
              Controls::Message.example,
              Controls::Message.example
            ]
          end
        end
      end
    end
  end
end

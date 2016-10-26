module Messaging
  module Controls
    module Message
      def self.example(time: nil, metadata: nil)
        time ||= self.time
        metadata ||= Controls::Metadata.example

        message = SomeMessage.new
        message.some_attribute = attribute
        message.some_time = time

        message.metadata = metadata

        message
      end

      class SomeMessage
        include Messaging::Message

        attribute :some_attribute
        attribute :some_time
      end

      def self.message_class
        SomeMessage
      end

      def self.attribute
        'some value'
      end

      def self.time
        Time.example
      end

      def self.data
        {
          some_attribute: attribute,
          some_time: time
        }
      end
    end
  end
end

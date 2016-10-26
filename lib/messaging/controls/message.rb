module Messaging
  module Controls
    module Message
      def self.example(time: nil, metadata: nil)
        time ||= self.time
        metadata ||= Metadata.example

        msg = SomeMessage.new
        msg.some_attribute = attribute
        msg.some_time = time

        ## When have metadata
        # msg.metadata = metadata

        msg
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

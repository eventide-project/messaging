module Messaging
  module Controls
    module Message
      def self.example(metadata: nil)
        metadata ||= Controls::Metadata.example

        message = SomeMessage.new
        message.some_attribute = attribute
        message.other_attribute = other_attribute

        message.metadata = metadata

        message
      end

      class SomeMessage
        include Messaging::Message

        attribute :some_attribute
        attribute :other_attribute
      end

      class OtherMessage
        include Messaging::Message

        attribute :an_attribute
        attribute :other_attribute
      end

      class SingleAttribute
        include Messaging::Message

        attribute :some_attribute
      end

      def self.message_class
        SomeMessage
      end

      def self.type
        'SomeMessage'
      end

      def self.attribute
        'some value'
      end

      def self.other_attribute
        'other value'
      end

      def self.data
        {
          some_attribute: attribute,
          other_attribute: other_attribute
        }
      end
    end
  end
end

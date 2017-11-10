module Messaging
  module Controls
    module Message
      def self.example(id: nil, some_attribute: nil, metadata: nil)
        if id == :none
          id = nil
        else
          id ||= self.id
        end

        some_attribute ||= attribute
        metadata ||= Controls::Metadata.example

        message = SomeMessage.new
        message.id = id
        message.some_attribute = some_attribute
        message.other_attribute = other_attribute

        message.metadata = metadata

        message
      end

      module New
        def self.example
          Message::SomeMessage.new
        end
      end

      class SomeMessage
        include Messaging::Message

        attribute :some_attribute
        attribute :other_attribute
      end
      Example = SomeMessage

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

      def self.id
        ID::Random.example
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

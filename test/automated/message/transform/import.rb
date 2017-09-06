require_relative '../../automated_init'

context "Message" do
  type = Controls::Message.type
  metadata = Controls::Metadata::Written.data
  data = Controls::Message.data

  message_data = Controls::MessageData::Read.example(type: type, data: data, metadata: metadata)

  context "Import" do
    message = Message::Import.(message_data, Controls::Message::SomeMessage)

    context "MessageData imported into message" do
      test "Message's type is the MessageData type" do
        assert(message.message_type == message_data.type)
      end

      test "Message's attributes are equal to the message data's attributes" do
        assert(message.to_h == message_data.data)
      end
    end
  end

  context "MessageData type is not the message's type" do
    test "Is an error" do
      assert proc { Message::Import.(message_data, Controls::Message::OtherMessage) } do
        raises_error? Message::Import::Error
      end
    end
  end
end

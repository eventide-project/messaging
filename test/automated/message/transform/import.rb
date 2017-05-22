require_relative '../../automated_init'

context "Message" do
  context "Import" do
    type = Controls::Message.type
    metadata = Controls::Metadata::Written.data
    data = Controls::Message.data

    message_data = Controls::MessageData::Read.example(type: type, data: data, metadata: metadata)

    message = Message::Import.(message_data, Controls::Message::SomeMessage)

    test "MessageData imported into message" do
      refute(message.nil?)
    end
  end
end

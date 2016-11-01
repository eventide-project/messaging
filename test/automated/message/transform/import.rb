require_relative '../../automated_init'

context "Message" do
  context "Import" do
    type = Controls::Message.type
    metadata = Controls::Metadata::Written.data
    data = Controls::Message.data

    event_data = Controls::EventData::Read.example(type: type, data: data, metadata: metadata)

    message = Message::Import.(event_data, Controls::Message::SomeMessage)

    test "EventData imported into message" do
      refute(message.nil?)
    end
  end
end

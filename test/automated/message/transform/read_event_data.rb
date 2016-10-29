require_relative '../../automated_init'

context "Message" do
  context "Transform" do
    context "Read EventData" do
      message = Controls::Message.example

      event_data = Transform::Write.(message, :event_data)

      context "Event Data's Data" do
        test "type is the message's message type" do
          assert(event_data.type == 'SomeMessage')
        end

        test "data is the message's data" do
          data = Controls::Message.data
          assert(event_data.data == data)
        end

        test "metadata is the message's metadata" do
          metadata = Controls::Metadata.data
          assert(event_data.metadata == metadata)
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Message" do
  context "Transform" do
    context "Write EventData" do
      context "Data" do
        message = Controls::Message.example

        event_data = Transform::Write.(message, :event_data)

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

      context "Empty Message Metadata" do
        metadata = Controls::Metadata::Empty.example
        message = Controls::Message.example(metadata: metadata)

        event_data = Transform::Write.(message, :event_data)

        test "EventData metadata has no fields" do
          assert(event_data.metadata.keys.empty?)
        end
      end
    end
  end
end

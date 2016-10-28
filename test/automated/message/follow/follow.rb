require_relative '../../automated_init'

context "Message" do
  context "Follow" do
    source = Controls::Message.example

    receiver = source.class.new

    Message::Follow.(source, receiver)

    context "Non-Workflow Attributes" do
      [:correlation_stream_name, :reply_stream_name, :schema_version].each do |attribute_name|
        test "#{attribute_name} is copied" do
          assert(receiver.metadata.public_send(attribute_name) == source.metadata.public_send(attribute_name))
        end
      end
    end

    context "Workflow attributes" do
      test "causation_event_stream_name is copied from source_event_stream_name" do
        assert(receiver.metadata.causation_event_stream_name == source.metadata.source_event_stream_name)
      end

      test "causation_event_position is copied from source_event_position" do
        assert(receiver.metadata.causation_event_position == source.metadata.source_event_position)
      end
    end

    context "Receiver's source event attributes" do
      unchanged_receiver = source.class.new

      context "Unchanged" do
        test "source_event_stream_name" do
          assert(receiver.metadata.source_event_stream_name == unchanged_receiver.metadata.source_event_stream_name)
        end

        test "source_event_position" do
          assert(receiver.metadata.source_event_position == unchanged_receiver.metadata.source_event_position)
        end
      end
    end
  end
end

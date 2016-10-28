require_relative '../../automated_init'

context "Message" do
  context "Follow" do
    source = Controls::Message.example

    receiver = source.class.new

    Message::Follow.(source, receiver)

    context "Workflow attributes are copied" do
      test "causation_event_stream_name is copied from source_event_stream_name" do
        assert(receiver.metadata.causation_event_stream_name == source.metadata.source_event_stream_name)
      end

      test "causation_event_position is copied from source_event_position" do
        assert(receiver.metadata.causation_event_position == source.metadata.source_event_position)
      end
    end

    context "Non-Workflow Attributes" do
      test "correlation_stream_name is copied" do
        assert(receiver.metadata.correlation_stream_name == source.metadata.correlation_stream_name)
      end

      test "reply_stream_name is copied" do
        assert(receiver.metadata.reply_stream_name == source.metadata.reply_stream_name)
      end
    end

    context "Receiver's source event attributes are unchanged" do
      unchanged_receiver = source.class.new

      test "source_event_stream_name" do
        assert(receiver.metadata.source_event_stream_name == unchanged_receiver.metadata.source_event_stream_name)
      end

      test "source_event_position" do
        assert(receiver.metadata.source_event_position == unchanged_receiver.metadata.source_event_position)
      end
    end

    context "Receiver's schema version attribute is unchanged" do
      unchanged_receiver = source.class.new

      test "schema_version" do
        assert(receiver.metadata.schema_version == unchanged_receiver.metadata.schema_version)
      end
    end
  end
end

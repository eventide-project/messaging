require_relative '../../automated_init'

context "Message" do
  context "Follow" do
    source = Controls::Message.example

    receiver = source.class.new

    Message::Follow.(source, receiver)

    context "Workflow attributes are copied" do
      test "causation_message_stream_name is copied from source_message_stream_name" do
        assert(receiver.metadata.causation_message_stream_name == source.metadata.source_message_stream_name)
      end

      test "causation_message_position is copied from source_message_position" do
        assert(receiver.metadata.causation_message_position == source.metadata.source_message_position)
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

    context "Receiver's source message attributes are unchanged" do
      unchanged_receiver = source.class.new

      test "source_message_stream_name" do
        assert(receiver.metadata.source_message_stream_name == unchanged_receiver.metadata.source_message_stream_name)
      end

      test "source_message_position" do
        assert(receiver.metadata.source_message_position == unchanged_receiver.metadata.source_message_position)
      end
    end

    context "Receiver's schema version attribute is unchanged" do
      unchanged_receiver = source.class.new

      test "schema_version" do
        assert(receiver.metadata.schema_version == unchanged_receiver.metadata.schema_version)
      end
    end

    test "Attributes are copied" do
      assert(receiver == source)
    end
  end
end

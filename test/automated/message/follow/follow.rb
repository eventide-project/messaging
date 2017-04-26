require_relative '../../automated_init'

context "Message" do
  context "Follow" do
    source = Controls::Message.example

    receiver = source.class.new

    Message::Follow.(source, receiver)

    test "Attributes are copied" do
      assert(receiver == source)
    end

    context "Metadata" do
      metadata = receiver.metadata
      source_metadata = source.metadata

      context "Copied from Source Metadata" do
        context "causation_event_stream_name" do
          test "Set from source_event_stream_name" do
            assert(metadata.causation_event_stream_name == source_metadata.source_event_stream_name)
          end
        end

        context "causation_event_position" do
          test "Set from source_event_position" do
            assert(metadata.causation_event_position == source_metadata.source_event_position)
          end
        end

        test "correlation_stream_name" do
          assert(metadata.correlation_stream_name == source_metadata.correlation_stream_name)
        end

        test "reply_stream_name" do
          assert(metadata.reply_stream_name == source_metadata.reply_stream_name)
        end
      end

      context "Not Copied from Source Metadata" do
        unchanged_metadata = Message::Metadata.new

        [
          :source_event_stream_name,
          :source_event_position,
          :global_position,
          :time,
          :schema_version
        ].each do |attribute|
          test attribute.to_s do
            assert(metadata.public_send(attribute) == unchanged_metadata.public_send(attribute))
          end
        end
      end
    end
  end
end

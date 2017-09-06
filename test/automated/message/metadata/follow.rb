require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follow" do
      source_metadata = Controls::Metadata.example
      metadata = Message::Metadata.new

      ## TODO Use:
      # - stream_name
      # - position
      # - global_position

      refute(metadata.causation_message_stream_name == source_metadata.source_message_stream_name)
      refute(metadata.causation_message_position == source_metadata.source_message_position)
      refute(metadata.causation_message_global_position == source_metadata.source_message_global_position)
      refute(metadata.correlation_stream_name == source_metadata.correlation_stream_name)
      refute(metadata.reply_stream_name == source_metadata.reply_stream_name)

      metadata.follow(source_metadata)

      context "Copied from Source Metadata" do
        context "causation_message_stream_name" do
          test "Set from source_message_stream_name" do
            assert(metadata.causation_message_stream_name == source_metadata.source_message_stream_name)
          end
        end

        context "causation_message_position" do
          test "Set from source_message_position" do
            assert(metadata.causation_message_position == source_metadata.source_message_position)
          end
        end

        context "causation_message_global_position" do
          test "Set from source_message_global_position" do
            assert(metadata.causation_message_global_position == source_metadata.source_message_global_position)
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
          :source_message_stream_name,
          :source_message_position,
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

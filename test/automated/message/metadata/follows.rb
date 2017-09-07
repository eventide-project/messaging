require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Workflow attributes are equal" do
        source_metadata = Controls::Metadata::Random.example
        metadata = Controls::Metadata::Random.example

        refute(metadata.causation_message_stream_name == source_metadata.stream_name)
        refute(metadata.causation_message_position == source_metadata.position)
        refute(metadata.causation_message_global_position == source_metadata.source_message_global_position)
        refute(metadata.correlation_stream_name == source_metadata.correlation_stream_name)
        refute(metadata.reply_stream_name == source_metadata.reply_stream_name)

        metadata.causation_message_stream_name = source_metadata.stream_name
        metadata.causation_message_position = source_metadata.position
        metadata.causation_message_global_position = source_metadata.source_message_global_position
        metadata.correlation_stream_name = source_metadata.correlation_stream_name
        metadata.reply_stream_name = source_metadata.reply_stream_name

        test "Metadata follows the precedent" do
          assert(metadata.follows?(source_metadata))
        end
      end
    end
  end

  context "Doesn't Follow" do
    source_metadata = Controls::Metadata::Random.example

    context "Any workflow attribute isn't equal" do
      [:stream_name, :correlation_stream_name, :reply_stream_name].each do |attribute|

        context "#{attribute}" do
          metadata = Controls::Metadata::Random.example

          metadata.causation_message_stream_name = source_metadata.stream_name
          metadata.causation_message_position = source_metadata.position
          metadata.causation_message_global_position = source_metadata.source_message_global_position
          metadata.correlation_stream_name = source_metadata.correlation_stream_name
          metadata.reply_stream_name = source_metadata.reply_stream_name

          assert(metadata.follows?(source_metadata))

          source_metadata.send "#{attribute}=", SecureRandom.hex

          test attribute.to_s do
            refute(metadata.follows?(source_metadata))
          end
        end
      end

      test "causation_message_position" do
        metadata = Controls::Metadata::Random.example

        metadata.causation_message_stream_name = source_metadata.stream_name
        metadata.causation_message_position = source_metadata.position
        metadata.causation_message_global_position = source_metadata.source_message_global_position
        metadata.correlation_stream_name = source_metadata.correlation_stream_name
        metadata.reply_stream_name = source_metadata.reply_stream_name

        assert(metadata.follows?(source_metadata))

        metadata.causation_message_position = Controls::Random::Number.example

        refute(metadata.follows?(source_metadata))
      end

      test "causation_message_global_position" do
        metadata = Controls::Metadata::Random.example

        metadata.causation_message_stream_name = source_metadata.stream_name
        metadata.causation_message_position = source_metadata.position
        metadata.causation_message_global_position = source_metadata.source_message_global_position
        metadata.correlation_stream_name = source_metadata.correlation_stream_name
        metadata.reply_stream_name = source_metadata.reply_stream_name

        assert(metadata.follows?(source_metadata))

        metadata.causation_message_global_position = Controls::Random::Number.example

        refute(metadata.follows?(source_metadata))
      end
    end
  end
end

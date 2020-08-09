require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Workflow Attributes Are Precedent" do
        source_metadata = Controls::Metadata::Random.example
        metadata = Controls::Metadata::Random.example

        refute(metadata.causation_message_stream_name == source_metadata.stream_name)
        refute(metadata.causation_message_position == source_metadata.position)
        refute(metadata.causation_message_global_position == source_metadata.global_position)
        refute(metadata.reply_stream_name == source_metadata.reply_stream_name)

## more refutes for preconditions

        metadata.causation_message_stream_name = source_metadata.stream_name
        metadata.causation_message_position = source_metadata.position
        metadata.causation_message_global_position = source_metadata.global_position
        metadata.reply_stream_name = source_metadata.reply_stream_name

_test "Need to take correlation stream into account" do
  assert(false)
end

        test "Metadata follows the precedent" do
          assert(metadata.follows?(source_metadata))
        end
      end
    end
  end
end

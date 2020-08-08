require_relative '../../../automated_init'

context "Message" do
  context "Follows" do
    context "Exclude" do
      context "All Attributes" do
        source_metadata = Controls::Metadata::Random.example
        metadata = Controls::Metadata::Random.example

        metadata.follow(source_metadata)

        metadata.causation_message_stream_name = SecureRandom.hex
        metadata.causation_message_position = Controls::Random::Number.example
        metadata.causation_message_global_position = Controls::Random::Number.example
        metadata.reply_stream_name = SecureRandom.hex

        workflow_attributes = Message::Metadata.workflow_attributes

        test "Follows" do
          assert(metadata.follows?(source_metadata, exclude: workflow_attributes))
        end
      end
    end
  end
end

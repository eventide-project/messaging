require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Exclude" do
        context "All Attributes" do
          source_message = Controls::Message.example
          message = Controls::Message.example

          message.metadata.follow(source_message.metadata)

          message.metadata.causation_message_stream_name = SecureRandom.hex
          message.metadata.causation_message_position = Controls::Random::Number.example
          message.metadata.causation_message_global_position = Controls::Random::Number.example
          message.metadata.reply_stream_name = SecureRandom.hex

          workflow_attributes = Message::Metadata.workflow_attributes

          test "Follows" do
            assert(message.follows?(source_message, exclude: workflow_attributes))
          end
        end
      end
    end
  end
end

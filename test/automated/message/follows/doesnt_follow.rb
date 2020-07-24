require_relative '../../automated_init'

context "Message" do
  context "Follows" do
    context "Doesn't Follow" do
      context "Any Workflow Attribute Isn't Precedent" do
        [:causation_message_stream_name, :reply_stream_name].each do |attribute|
          source_message = Controls::Message.example
          message = Controls::Message.example

          message.metadata.follow(source_message.metadata)

          message.metadata.send "#{attribute}=", SecureRandom.hex

          test attribute.to_s do
            refute(message.follows?(source_message))
          end
        end

        test "causation_message_position" do
          source_message = Controls::Message.example
          message = Controls::Message.example

          message.metadata.follow(source_message.metadata)

          message.metadata.causation_message_position = Controls::Random::Number.example

          refute(message.follows?(source_message))
        end

        test "causation_message_global_position" do
          source_message = Controls::Message.example
          message = Controls::Message.example

          message.metadata.follow(source_message.metadata)

          message.metadata.causation_message_global_position = Controls::Random::Number.example

          refute(message.follows?(source_message))
        end
      end
    end
  end
end

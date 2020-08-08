require_relative '../../automated_init'

context "Message" do
  context "Follows" do
    context "Exclude" do
      context "Single Attributes" do
        [:causation_message_stream_name, :reply_stream_name].each do |attribute|
          source_message = Controls::Message.example
          message = Controls::Message.example

          message.metadata.follow(source_message.metadata)

          message.metadata.send "#{attribute}=", SecureRandom.hex

          test attribute.to_s do
            assert(message.follows?(source_message, exclude: attribute))
          end
        end

        test "causation_message_position" do
          source_message = Controls::Message.example
          message = Controls::Message.example

          message.metadata.follow(source_message.metadata)

          message.metadata.causation_message_position = Controls::Random::Number.example

          assert(message.follows?(source_message, exclude: :causation_message_position))
        end

        test "causation_message_global_position" do
          source_message = Controls::Message.example
          message = Controls::Message.example

          message.metadata.follow(source_message.metadata)

          message.metadata.causation_message_global_position = Controls::Random::Number.example

          assert(message.follows?(source_message, exclude: :causation_message_global_position))
        end
      end
    end
  end
end

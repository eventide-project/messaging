require_relative '../automated_init'

context "Message" do
  context "Follows" do
    context "Metadata has precedence" do
      source_message = Controls::Message.example
      message = Controls::Message.example

      message.metadata.follow(source_message.metadata)

      test "Message follows" do
        assert(message.follows?(source_message))
      end
    end
  end

  context "Any workflow attribute isn't equal" do
    [:causation_message_stream_name, :correlation_stream_name, :reply_stream_name].each do |attribute|
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

      message.metadata.causation_message_position = -1

      refute(message.follows?(source_message))
    end
  end
end

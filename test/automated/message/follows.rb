require_relative '../automated_init'

context "Message" do
  context "Follows" do
    context "Metadata have precedence" do
      source_message = Controls::Message.example
      message = Controls::Message.example

      message.metadata.follow(source_message.metadata)

      test "Message has precedence" do
        assert(message.follows?(source_message))
      end
    end
  end

  context "Any workflow attributes are not equal" do
    [:causation_event_stream_name, :causation_event_position, :correlation_stream_name, :reply_stream_name].each do |attribute|
      source_message = Controls::Message.example
      message = Controls::Message.example

      message.metadata.follow(source_message.metadata)

      message.metadata.send "#{attribute}=", SecureRandom.hex

      test attribute.to_s do
        refute(message.follows?(source_message))
      end
    end
  end
end

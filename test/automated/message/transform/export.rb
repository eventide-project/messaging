require_relative '../../automated_init'

context "Message" do
  context "Export" do
    message = Controls::Message.example

    message_data = Message::Export.(message)

    context "Message is exported to MessageData" do
      test "MessageData type is Message's type" do
        assert(message.message_type == message.message_type)
      end

      test "Message's attributes are equal to the message data's attributes" do
        assert(message.to_h == message_data.data)
      end
    end
  end





    test "Message exported to MessageData" do
      refute(message_data.nil?)
    end
  end
end

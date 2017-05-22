require_relative '../../automated_init'

context "Message" do
  context "Export" do
    message = Controls::Message.example

    message_data = Message::Export.(message)

    test "Message exported to MessageData" do
      refute(message_data.nil?)
    end
  end
end

require_relative '../../automated_init'

context "Message" do
  context "Export" do
    message = Controls::Message.example

    event_data = Message::Export.(message)

    test "Message exported to EventData" do
      refute(event_data.nil?)
    end
  end
end

require_relative '../../automated_init'

context "Handle" do
  context "MessageData as Data" do
    context "No Message Class Registered" do
      context "Handler Implements Handler Method for MessageData's Type" do
        context "Message Handler" do
          message_data = Controls::MessageData::Read.example(type: 'UnregisteredMessage')

          test "Is an error" do
            assert proc { Controls::Handler::UnregisteredMessage::Example.(message_data) } do
              raises_error? Messaging::Handle::Error
            end
          end
        end
      end
    end
  end
end

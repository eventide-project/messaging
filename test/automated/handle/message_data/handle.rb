require_relative '../../automated_init'

context "Handle" do
  context "MessageData" do
    context "Handle" do
      context "Handler Implements Handle" do
        message_data = Controls::MessageData::Read.example(data: 1)

        Controls::Handler::HandleMethod::Example.(message_data)

        test "Message data is handled" do
          assert(message_data.data == 'some value set by handle method')
        end
      end

      context "Handler Does Not Implement Handle" do
        message_data = Controls::MessageData::Read.example(data: 1)

        unchanged_data = message_data.data

        Controls::Handler::Anomaly::NoHandle::Example.(message_data)

        test "Message data is not handled" do
          assert(message_data.data == unchanged_data)
        end
      end
    end
  end
end

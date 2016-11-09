require_relative '../../automated_init'

context "Handle" do
  context "Message" do
    context "Handle" do
      context "Handler Implements Handler for Message" do
        message = Controls::Message::New.example

        Controls::Handler::Example.(message)

        test "Message is handled" do
          assert(message.some_attribute == 'some value set by handler')
        end
      end

      context "Handler Does Not Implement Handle" do
        message = Controls::Message::New.example

        unchanged_attribute = message.some_attribute

        Controls::Handler::Anomaly::NoHandle::Example.(message)

        test "Message is not handled" do
          assert(message.some_attribute == unchanged_attribute)
        end
      end
    end
  end
end

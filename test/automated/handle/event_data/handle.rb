require_relative '../../automated_init'

context "Handle" do
  context "EventData" do
    context "Handle" do
      context "Handler Implements Handle" do
        message = Controls::Message::New.example

        Controls::Handler::Message::Example.(message)

        test "Message is handled" do
          assert(message.some_attribute == 'some value set by handler')
        end
      end

      context "Handler Does Not Implement Handle" do
        message = Controls::Message::New.example

        unchanged_attribute = message.some_attribute

        Controls::Handler::NoHandle::Example.(message)

        test "Message is not handled" do
          assert(message.some_attribute == unchanged_attribute)
        end
      end
    end
  end
end

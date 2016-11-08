require_relative '../../automated_init'

context "Handle" do
  context "Message" do
    context "Strict" do
      context "Handler Implements Handler for Message" do
        message = Controls::Message::New.example

        Controls::Handler::Message::Example.(message, strict: true)

        test "Message is handled" do
          assert(message.some_attribute == 'some value set by handler')
        end
      end

      context "Handler Does Not Implement Handle" do
        message = Controls::Message::New.example

        test "Is an error" do
          assert proc { Controls::Handler::NoHandle::Example.(message, strict: true) } do
            raises_error? Handle::Error
          end
        end
      end
    end
  end
end

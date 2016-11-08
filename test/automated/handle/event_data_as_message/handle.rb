require_relative '../../automated_init'

context "Handle" do
  context "Message" do
    context "Handle" do
      context "Handler Implements Handler for EventData Type" do
        event_data = Controls::EventData::Read.example(type: 'SomeMessage')

        message = Controls::Handler::Message::Example.(event_data)

        test "Message is handled" do
          assert(message.some_attribute == 'some value set by handler')
        end
      end

      # context "Handler Does Not Implement Handle" do
      #   message = Controls::Message::New.example

      #   unchanged_attribute = message.some_attribute

      #   Controls::Handler::NoHandle::Example.(message)

      #   test "Message is not handled" do
      #     assert(message.some_attribute == unchanged_attribute)
      #   end
      # end
    end
  end
end

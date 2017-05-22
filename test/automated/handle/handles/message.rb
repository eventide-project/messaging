require_relative '../../automated_init'

context "Handles" do
  context "Message" do
    context "Handler Implements Message Handler for the Message Class" do
      message = Controls::Message.example
      handles = Controls::Handler::Example.handles? message

      test "Handles" do
        assert(handles)
      end
    end

    context "Handler Does not Implement Message Handler for MessageData's Type" do
      message = Controls::Message::OtherMessage.new
      handles = Controls::Handler::Example.handles? message

      test "Does not Handle" do
        refute(handles)
      end
    end
  end
end

require_relative '../../automated_init'

context "Handles" do
  context "Message Type" do
    context "Handler Implements Message Handler for Message Type" do
      message_type = 'SomeMessage'
      handles = Controls::Handler::Example.handles? message_type

      test "Handles" do
        assert(handles)
      end
    end

    context "Handler Does not Implement Message Handler for Message Type" do
      message_type = SecureRandom.hex
      handles = Controls::Handler::Example.handles? message_type

      test "Does not Handle" do
        refute(handles)
      end
    end
  end
end

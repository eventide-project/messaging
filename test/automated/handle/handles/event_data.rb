require_relative '../../automated_init'

context "Handles" do
  context "MessageData" do
    context "Handler Implements Message Handler for MessageData's Type" do
      message_data = Controls::MessageData::Read.example(type: 'SomeMessage')
      handles = Controls::Handler::Example.handles? message_data

      test "Handles" do
        assert(handles)
      end
    end

    context "Handler Does not Implement Message Handler for MessageData's Type" do
      message_data = Controls::MessageData::Read.example(type: SecureRandom.hex)
      handles = Controls::Handler::Example.handles? message_data

      test "Does not Handle" do
        refute(handles)
      end
    end
  end
end

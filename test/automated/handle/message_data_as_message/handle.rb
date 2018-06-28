require_relative '../../automated_init'

context "Handle" do
  context "MessageData as Data" do
    context "Handle" do
      context "Handler Implements Message Handler for MessageData's Type" do
        context "Message Handler" do
          message_data = Controls::MessageData::Read.example(type: 'SomeMessage')

          message = Controls::Handler::Example.(message_data)

          test "MessageData is handled as Message" do
            assert(message.some_attribute == 'some value set by handler')
          end
        end

        context "MessageData Handler" do
          read_message_data = Controls::MessageData::Read.example(type: 'SomeMessage')

          unchanged_data = read_message_data.data

          message = Controls::Handler::BlockAndHandleMethod::Example.(read_message_data)

          message_data = message.to_h

          test "MessageData is not handled as MessageData" do
            refute(read_message_data.data == message_data )
          end
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Write" do
  context "Message" do
    context "Writing the initial message to a stream that has not been created yet" do
      stream_name = Controls::StreamName.example

      message = Controls::Message.example

      write = Write.build

      write.initial(message, stream_name)

      read_message = MessageStore::Get.(stream_name, position: 0, batch_size: 1).first

      test "Writes the message" do
        assert(read_message.data == message.to_h)
      end
    end

    context "Writing the initial message to a stream that already exists" do
      stream_name = Controls::StreamName.example

      message = Controls::Message.example

      write = Write.build

      write.(message, stream_name)

      test "Is an error" do
        assert_raises(MessageStore::ExpectedVersion::Error) do
          write.initial(message, stream_name)
        end
      end
    end
  end
end

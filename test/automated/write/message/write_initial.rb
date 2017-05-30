require_relative '../../automated_init'

context "Write" do
  context "Message" do
    context "Writing the initial event to a stream that has not been created yet" do
      stream_name = Controls::StreamName.example

      message = Controls::Message.example

      write = Write.build

      write.initial(message, stream_name)

      read_event = MessageStore::Postgres::Get.(stream_name, position: 0, batch_size: 1).first

      test "Writes the message" do
        assert(read_event.data == message.to_h)
      end
    end

    context "Writing the initial event to a stream that already exists" do
      stream_name = Controls::StreamName.example

      message = Controls::Message.example

      write = Write.build

      write.(message, stream_name)

      test "Is an error" do
        assert proc { write.initial(message, stream_name) } do
          raises_error? MessageStore::ExpectedVersion::Error
        end
      end
    end
  end
end

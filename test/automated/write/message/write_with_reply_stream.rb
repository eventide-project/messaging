require_relative '../../automated_init'

context "Write" do
  context "Message" do
    context "With Reply Stream" do
      message = Controls::Message.example

      stream_name = Controls::StreamName.example
      reply_stream_name = Controls::StreamName.example

      position = Write.(message, stream_name, reply_stream_name: reply_stream_name)

      read_message = MessageStore::Get.(stream_name, position: position, batch_size: 1).first

      test "Sets the metadata reply stream name" do
        assert(read_message.metadata[:reply_stream_name] == reply_stream_name)
      end
    end
  end
end

require_relative '../../automated_init'

context "Write" do
  context "Message" do
    stream_name = Controls::StreamName.example

    message = Controls::Message.example

    written_position = Write.(message, stream_name)

    read_event = EventSource::Postgres::Get.(stream_name, position: written_position, batch_size: 1).first

    test "Writes the message" do
      assert(read_event.data == message.to_h)
    end
  end
end

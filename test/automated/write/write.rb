require_relative '../automated_init'

context "Write" do
  context "Single Message" do
    stream = Controls::Stream.example

    message = Controls::Message.example

    written_position = Write.(message, stream.name)

    read_event = EventSource::Postgres::Get.(stream, position: written_position, batch_size: 1).first

    test "Writes the message" do
      assert(read_event.data == message.to_h)
    end
  end
end

require_relative '../automated_init'

context "Write" do
  stream = Controls::Stream.example

  message = Controls::Message.example

  written_position = Write.(message, stream.name)

  ## Can't bind to postgres here, can we?
  ## Need to separate

  read_message = nil
  EventSource::Postgres::Read.(stream.name, position: written_position, batch_size: 1) do |event_data|
    read_message = Message::Import.(event_data, message.class)
  end

  test "Got the event that was written" do
    assert(read_message == message)
  end
end

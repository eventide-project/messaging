require_relative '../automated_init'

context "Write" do
  stream = Controls::Stream.example
  message = Controls::Message.example

  written_position = Write.(message, stream.name)

  read_message = Get.(stream, position: written_position).first

  test "Got the event that was written" do
    assert(read_message == message)
  end
end

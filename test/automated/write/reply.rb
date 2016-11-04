require_relative '../automated_init'

context "Write" do
  context "Replying to a Message" do
    message = Controls::Message.example

    reply_stream_name = Controls::StreamName.example(category: 'replyToTestReply')
    message.metadata.reply_stream_name = reply_stream_name

    writer = Messaging::Postgres::Write.build

    written_position = writer.reply(message)

    stream = Controls::Stream.example(stream_name: reply_stream_name)
    read_event = EventSource::Postgres::Get.(stream, position: written_position, batch_size: 1).first

    test "Writes the message to the reply stream" do
      assert(read_event.data == message.to_h)
    end
  end
end

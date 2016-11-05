require_relative '../../automated_init'

context "Write" do
  context "Batch" do
    context "With Reply Stream" do
      stream_name = Controls::StreamName.example(category: 'testWriteReplyStreamBatch')
      reply_stream_name = Controls::StreamName.example(category: 'testWriteReplyStreamBatchReplyStream')

      message_1 = Controls::Message.example(some_attribute: 'value_1')
      message_2 = Controls::Message.example(some_attribute: 'value_2')

      batch = [message_1, message_2]

      Write.(batch, stream_name, reply_stream_name: reply_stream_name)

      context "Individual Events are Written" do
        2.times do |i|
          read_event = EventSource::Postgres::Get.(stream_name, position: i, batch_size: 1).first

          test "Event #{i + 1}" do
            assert(read_event.metadata[:reply_stream_name] == reply_stream_name)
          end
        end
      end
    end
  end
end

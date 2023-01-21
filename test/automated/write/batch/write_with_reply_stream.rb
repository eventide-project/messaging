require_relative '../../automated_init'

context "Write" do
  context "Batch" do
    context "With Reply Stream" do
      stream_name = Controls::StreamName.example
      reply_stream_name = Controls::StreamName.example

      batch, values = Controls::Batch.example

      Write.(batch, stream_name, reply_stream_name: reply_stream_name)

      context "Individual Events are Written" do
        2.times do |i|
          read_message = MessageStore::Get.(stream_name, position: i, batch_size: 1).first

          test "Event #{i + 1}" do
            assert(read_message.data[:some_attribute] == values[i])
          end
        end
      end
    end
  end
end

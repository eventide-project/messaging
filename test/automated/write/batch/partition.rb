require_relative '../../automated_init'

context "Write" do
  context "Batch" do
    context "Partition" do
      stream_name = Controls::StreamName.example(category: 'testWriteBatchPartition')

      partition = Controls::Partition.example

      message_1 = Controls::Message.example(some_attribute: 'value_1')
      message_2 = Controls::Message.example(some_attribute: 'value_2')

      batch = [message_1, message_2]

      last_written_position = Write.(batch, stream_name, partition: partition)

      test "Last written position" do
        assert(last_written_position == 1)
      end

      context "Individual Events are Written" do
        2.times do |i|
          read_event = EventSource::Postgres::Get.(stream_name, partition: partition, position: i, batch_size: 1).first

          test "Event #{i + 1}" do
            assert(read_event.data[:some_attribute] == "value_#{i + 1}")
          end
        end
      end
    end
  end
end

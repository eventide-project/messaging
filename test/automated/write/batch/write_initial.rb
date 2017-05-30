require_relative '../../automated_init'

context "Write" do
  context "Batch" do
    context "Writing the initial message to a stream that has not been created yet" do
      stream_name = Controls::StreamName.example

      batch, values = Controls::Batch.example

      write = Write.build

      write.initial(batch, stream_name)

      context "Individual Events are Written" do
        2.times do |i|
          read_message = MessageStore::Postgres::Get.(stream_name, position: i, batch_size: 1).first

          test "Event #{i + 1}" do
            assert(read_message.data[:some_attribute] == values[i])
          end
        end
      end
    end

    context "Writing the initial message to a stream that already exists" do
      stream_name = Controls::StreamName.example

      batch = Controls::Batch::Messages.example

      write = Write.build

      message = Controls::Message.example
      Write.(message, stream_name)

      test "Is an error" do
        assert proc { write.initial(batch, stream_name) } do
          raises_error? MessageStore::ExpectedVersion::Error
        end
      end
    end
  end
end

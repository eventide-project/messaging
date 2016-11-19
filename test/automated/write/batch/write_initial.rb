require_relative '../../automated_init'

context "Write" do
  context "Batch" do
    context "Writing the initial event to a stream that has not been created yet" do
      stream_name = Controls::StreamName.example(category: 'testWriteInitialBatch')

      message_1 = Controls::Message.example(some_attribute: 'value_1')
      message_2 = Controls::Message.example(some_attribute: 'value_2')

      batch = [message_1, message_2]

      writer = Write.build

      writer.write_initial(batch, stream_name)

      context "Individual Events are Written" do
        2.times do |i|
          read_event = EventSource::Postgres::Get.(stream_name, position: i, batch_size: 1).first

          test "Event #{i + 1}" do
            assert(read_event.data[:some_attribute] == "value_#{i + 1}")
          end
        end
      end
    end

    context "Writing the initial event to a stream that already exists" do
      stream_name = Controls::StreamName.example

      message_1 = Controls::Message.example
      message_2 = Controls::Message.example

      batch = [message_1, message_2]

      writer = Write.build

      message = Controls::Message.example
      Write.(message, stream_name)

      test "Is an error" do
        assert proc { writer.write_initial(batch, stream_name) } do
          raises_error? EventSource::ExpectedVersion::Error
        end
      end
    end
  end
end

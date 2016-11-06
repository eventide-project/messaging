require_relative '../../../automated_init'

context "Write" do
  context "Telemetry" do
    context "Batch" do
      context "Write" do
        stream_name = Controls::StreamName.example(category: 'testWriteBatchTelemetry')

        message_1 = Controls::Message.example(some_attribute: 'value_1')
        message_2 = Controls::Message.example(some_attribute: 'value_2')

        batch = [message_1, message_2]

        writer = Controls::Write.example

        sink = Write.register_telemetry_sink(writer)

        writer.write(batch, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

        test "Records written telemetry" do
          assert(sink.written_records.count == batch.length)
        end

        context "Recorded Data" do
          2.times do |i|
            data = sink.records[i].data

            test "message" do
              assert(data.message == batch[i])
            end

            test "stream_name" do
              assert(data.stream_name == stream_name)
            end

            test "expected_version" do
              assert(data.expected_version == 11)
            end

            test "reply_stream_name" do
              assert(data.reply_stream_name == 'someReplyStreamName')
            end
          end
        end
      end
    end
  end
end

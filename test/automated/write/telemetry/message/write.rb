require_relative '../../../automated_init'

context "Write" do
  context "Telemetry" do
    context "Message" do
      context "Write" do
        message = Controls::Message.example
        stream_name = Controls::StreamName.example(category: 'testTelemetryWrite')

        writer = Controls::Write.example

        sink = Write.register_telemetry_sink(writer)

        writer.write(message, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

        test "Records written telemetry" do
          assert(sink.recorded_written?)
        end

        context "Recorded Data" do
          data = sink.records[0].data

          test "message" do
            assert(data.message == message)
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

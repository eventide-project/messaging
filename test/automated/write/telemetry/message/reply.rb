require_relative '../../../automated_init'

context "Write" do
  context "Telemetry" do
    context "Message" do
      context "Reply" do
        message = Controls::Message.example

        reply_stream_name = message.metadata.reply_stream_name

        writer = Controls::Write.example

        sink = Write.register_telemetry_sink(writer)

        writer.reply(message)

        test "Records replied telemetry" do
          assert(sink.recorded_replied?)
        end

        context "Recorded Data" do
          data = sink.records[0].data

          test "message" do
            assert(data.message == message)
          end

          test "stream_name" do
            assert(data.stream_name == reply_stream_name)
          end

          test "expected_version" do
            assert(data.expected_version.nil?)
          end

          test "reply_stream_name" do
            assert(data.reply_stream_name.nil?)
          end
        end
      end
    end
  end
end

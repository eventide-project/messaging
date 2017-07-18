require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Write" do
        message = Controls::Message.example
        stream_name = Controls::StreamName.example(category: 'testSubstituteWrite')

        writer = Write::Substitute.build

        writer.(message, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

        context "Written Messages" do
          test "No block arguments" do
            assert(writer.message_writes.length == 1)
          end

          test "Message block argument only" do
            assert(writer.message_writes { |msg| msg == message }.length == 1 )
          end

          test "Message and stream name block arguments" do
            assert(writer.message_writes { |msg, stream| stream == stream_name }.length == 1)
          end

          test "Message, stream name, and expected_version block arguments" do
            assert(writer.message_writes { |msg, stream, expected_version | expected_version == 11 }.length == 1)
          end

          test "Message, stream name, expected_version, and reply_stream_name block arguments" do
            assert(writer.message_writes { |msg, stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' }.length == 1)
          end
        end
      end
    end
  end
end


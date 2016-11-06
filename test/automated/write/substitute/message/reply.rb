require_relative '../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Reply" do
        message = Controls::Message.example

        reply_stream_name = message.metadata.reply_stream_name

        writer = Write::Substitute.build

        writer.reply(message)

        context "Detection Interrogatives" do
          test "No block arguments" do
            assert(writer.replied?)
          end

          test "Message block argument only" do
            assert(writer.replied? { |msg| msg == message })
          end

          test "Message and stream name block arguments" do
            assert(writer.replied? { |msg, stream| stream == reply_stream_name })
          end

          test "Message, stream name, and expected_version block arguments" do
            assert(writer.replied? { |msg, stream, expected_version | expected_version == nil })
          end

          test "Message, stream name, expected_version, and reply_stream_name block arguments" do
            assert(writer.replied? { |msg, stream, expected_version, reply_stream_name | reply_stream_name == nil })
          end
        end

        context "Recorded Data" do
          test "No block arguments" do
            assert(writer.replies.length == 1)
          end

          test "Message block argument only" do
            assert(writer.replies { |msg| msg == message }.length == 1 )
          end

          test "Message and stream name block arguments" do
            assert(writer.replies { |msg, stream| stream == reply_stream_name }.length == 1)
          end

          test "Message, stream name, and expected_version block arguments" do
            assert(writer.writes { |msg, stream, expected_version | expected_version == nil }.length == 1)
          end

          test "Message, stream name, expected_version, and reply_stream_name block arguments" do
            assert(writer.writes { |msg, stream, expected_version, reply_stream_name | reply_stream_name == nil }.length == 1)
          end
        end
      end
    end
  end
end

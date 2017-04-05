require_relative '../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Write" do
        message = Controls::Message.example
        stream_name = Controls::StreamName.example(category: 'testSubstituteWrite')

        writer = Write::Substitute.build

        writer.write(message, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

        context "Detection Interrogatives" do
          context "No Message Argument" do
            test "No block argument" do
              assert(writer.written?)
            end

            test "Message block argument only" do
              assert(writer.written? { |msg| msg == message })
            end

            test "Message and stream name block arguments" do
              assert(writer.written? { |msg, stream| stream == stream_name })
            end

            test "Message, stream name, and expected_version block arguments" do
              assert(writer.written? { |msg, stream, expected_version | expected_version == 11 })
            end

            test "Message, stream name, expected_version, and reply_stream_name block arguments" do
              assert(writer.written? { |msg, stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' })
            end
          end

          context "Message Argument" do
            test "No block argument" do
              assert(writer.written?(message))
            end

            test "Stream name block argument" do
              assert(writer.written?(message) { |stream| stream == stream_name })
            end

            test "Stream name, and expected_version block arguments" do
              assert(writer.written?(message) { |stream, expected_version | expected_version == 11 })
            end

            test "Stream name, expected_version, and reply_stream_name block arguments" do
              assert(writer.written?(message) { |stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' })
            end
          end
        end

        context "Recorded Data" do
          test "No block arguments" do
            assert(writer.writes.length == 1)
          end

          test "Message block argument only" do
            assert(writer.writes { |msg| msg == message }.length == 1 )
          end

          test "Message and stream name block arguments" do
            assert(writer.writes { |msg, stream| stream == stream_name }.length == 1)
          end

          test "Message, stream name, and expected_version block arguments" do
            assert(writer.writes { |msg, stream, expected_version | expected_version == 11 }.length == 1)
          end

          test "Message, stream name, expected_version, and reply_stream_name block arguments" do
            assert(writer.writes { |msg, stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' }.length == 1)
          end
        end

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

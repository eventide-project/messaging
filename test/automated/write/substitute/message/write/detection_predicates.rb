require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      message = Controls::Message.example
      stream_name = Controls::StreamName.example(category: 'testSubstituteWrite')

      context "Message Is Determined to Be Written" do
        writer = Write::Substitute.build

        writer.(message, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

        context "Detection Predicates" do
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
              assert(writer.written? { |msg, stream, expected_version| expected_version == 11 })
            end

            test "Message, stream name, expected_version, and reply_stream_name block arguments" do
              assert(writer.written? { |msg, stream, expected_version, reply_stream_name| reply_stream_name == 'someReplyStreamName' })
            end
          end

          context "Message Argument" do
            context "Message That Was Written" do
              test "No block argument" do
                assert(writer.written?(message))
              end

              test "Stream name block argument" do
                assert(writer.written?(message) { |stream| stream == stream_name })
              end

              test "Stream name, and expected_version block arguments" do
                assert(writer.written?(message) { |stream, expected_version| expected_version == 11 })
              end

              test "Stream name, expected_version, and reply_stream_name block arguments" do
                assert(writer.written?(message) { |stream, expected_version, reply_stream_name| reply_stream_name == 'someReplyStreamName' })
              end
            end

            context "Message That Was Not Written" do
              other_message = Controls::Message::SomeMessage.build

              test "No block argument" do
                refute(writer.written?(other_message))
              end
            end
          end
        end
      end

      context "Message Is Determined to Not Be Written" do
        writer = Write::Substitute.build

        context "Detection Predicates" do
          context "No Message Argument" do
            test "No block argument" do
              refute(writer.written?)
            end

            test "Message block argument only" do
              refute(writer.written? { |msg| msg == message })
            end

            test "Message and stream name block arguments" do
              refute(writer.written? { |msg, stream| stream == stream_name })
            end

            test "Message, stream name, and expected_version block arguments" do
              refute(writer.written? { |msg, stream, expected_version| expected_version == 11 })
            end

            test "Message, stream name, expected_version, and reply_stream_name block arguments" do
              refute(writer.written? { |msg, stream, expected_version, reply_stream_name| reply_stream_name == 'someReplyStreamName' })
            end
          end

          context "Message Argument" do
            test "No block argument" do
              refute(writer.written?(message))
            end

            test "Stream name block argument" do
              refute(writer.written?(message) { |stream| stream == stream_name })
            end

            test "Stream name, and expected_version block arguments" do
              refute(writer.written?(message) { |stream, expected_version| expected_version == 11 })
            end

            test "Stream name, expected_version, and reply_stream_name block arguments" do
              refute(writer.written?(message) { |stream, expected_version, reply_stream_name| reply_stream_name == 'someReplyStreamName' })
            end
          end
        end
      end
    end
  end
end

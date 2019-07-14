require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Batch" do
      stream_name = Controls::StreamName.example(category: 'testWriteBatchTelemetry')

      message_1 = Controls::Message.example(some_attribute: 'value_1')
      message_2 = Controls::Message.example(some_attribute: 'value_2')

      batch = [message_1, message_2]

      context "Batch Is Determined to Be Written" do
        write = Write::Substitute.build

        write.(batch, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

        context "Detection Predicates" do
          test "No block arguments" do
            assert(write.written?)
          end

          2.times do |i|
            context "Message #{i}" do
              test "Message block argument only" do
                assert(write.written? { |msg| msg == batch[i] })
              end
            end
          end

          test "Message and stream name block arguments" do
            assert(write.written? { |msg, stream| stream == stream_name })
          end

          test "Message, stream name, and expected_version block arguments" do
            assert(write.written? { |msg, stream, expected_version | expected_version == 11 })
          end

          test "Message, stream name, expected_version, and reply_stream_name block arguments" do
            assert(write.written? { |msg, stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' })
          end
        end
      end

      context "Batch Is Determined to Not Be Written" do
        write = Write::Substitute.build

        context "Detection Predicates" do
          test "No block arguments" do
            refute(write.written?)
          end

          2.times do |i|
            context "Message #{i}" do
              test "Message block argument only" do
                refute(write.written? { |msg| msg == batch[i] })
              end
            end
          end

          test "Message and stream name block arguments" do
            refute(write.written? { |msg, stream| stream == stream_name })
          end

          test "Message, stream name, and expected_version block arguments" do
            refute(write.written? { |msg, stream, expected_version | expected_version == 11 })
          end

          test "Message, stream name, expected_version, and reply_stream_name block arguments" do
            refute(write.written? { |msg, stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' })
          end
        end
      end
    end
  end
end

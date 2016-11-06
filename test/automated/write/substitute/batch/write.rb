require_relative '../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Batch" do
      context "Write" do
        stream_name = Controls::StreamName.example(category: 'testWriteBatchTelemetry')

        message_1 = Controls::Message.example(some_attribute: 'value_1')
        message_2 = Controls::Message.example(some_attribute: 'value_2')

        batch = [message_1, message_2]

        writer = Write::Substitute.build

        writer.write(batch, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

        context "Detection Interrogatives" do
          test "No block arguments" do
            assert(writer.written?)
          end

          2.times do |i|
            context "Message #{i}" do
              test "Message block argument only" do
                assert(writer.written? { |msg| msg == batch[i] })
              end
            end
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

        context "Recorded Data" do
          test "No block arguments" do
            assert(writer.writes.length == 2)
          end

          2.times do |i|
            context "Message #{i}" do
              test "Message block argument only" do
                assert(writer.writes { |msg| msg == batch[i] }.length == 1 )
              end
            end
          end

          test "Message and stream name block arguments" do
            assert(writer.writes { |msg, stream| stream == stream_name }.length == 2)
          end

          test "Message, stream name, and expected_version block arguments" do
            assert(writer.writes { |msg, stream, expected_version | expected_version == 11 }.length == 2)
          end

          test "Message, stream name, expected_version, and reply_stream_name block arguments" do
            assert(writer.writes { |msg, stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' }.length == 2)
          end
        end
      end
    end
  end
end

require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Write" do
        message = Controls::Message.example
        stream_name = Controls::StreamName.example(category: 'testSubstituteWrite')

        context "Written Message" do
          context "One Matching Message" do
            writer = Write::Substitute.build
            writer.(message, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')

            test "No block arguments" do
              assert(writer.one_message_write == message)
            end

            test "Message block argument only" do
              assert(writer.one_message_write { |msg| msg == message } == message)
            end

            test "Message and stream name block arguments" do
              assert(writer.one_message_write { |msg, stream| stream == stream_name } == message)
            end

            test "Message, stream name, and expected_version block arguments" do
              assert(writer.one_message_write { |msg, stream, expected_version | expected_version == 11 } == message)
            end

            test "Message, stream name, expected_version, and reply_stream_name block arguments" do
              assert(writer.one_message_write { |msg, stream, expected_version, reply_stream_name | reply_stream_name == 'someReplyStreamName' } == message)
            end
          end

          context "More than One Matching Message" do
            writer = Write::Substitute.build

            2.times do
              writer.write(message, stream_name, expected_version: 11, reply_stream_name: 'someReplyStreamName')
            end

            test "Is an error" do
              assert_raises(Write::Substitute::Error) do
                writer.one_message_write { |msg| msg.instance_of?(message.class) }
              end
            end
          end

          context "No Matching Message" do
            writer = Write::Substitute.build

            message = writer.one_message_write

            test "Message is nil" do
              assert(message.nil?)
            end
          end
        end
      end
    end
  end
end

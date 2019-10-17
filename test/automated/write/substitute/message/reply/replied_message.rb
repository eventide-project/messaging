require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Reply" do
        context "Replied Message" do
          context "One Matching Message" do
            message = Controls::Message.example
            reply_stream_name = message.metadata.reply_stream_name

            writer = Write::Substitute.build

            writer.reply(message)

            test "No block arguments" do
              assert(writer.one_message_reply == message)
            end

            test "Message block argument only" do
              assert(writer.one_message_reply { |msg| msg == message } == message)
            end

            test "Message and stream name block arguments" do
              assert(writer.one_message_reply { |msg, stream| stream == reply_stream_name } == message)
            end
          end

          context "More than One Matching Message" do
            message = Controls::Message.example
            reply_stream_name = message.metadata.reply_stream_name

            writer = Write::Substitute.build

            2.times do
              message = Controls::Message.example

              writer.reply(message)
            end

            test "Is an error" do
              assert_raises(Write::Substitute::Error) do
                writer.one_message_reply { |msg| msg.instance_of?(message.class) }
              end
            end
          end

          context "No Matching Message" do
            writer = Write::Substitute.build

            message = writer.one_message_reply

            test "Message is nil" do
              assert(message.nil?)
            end
          end
        end
      end
    end
  end
end

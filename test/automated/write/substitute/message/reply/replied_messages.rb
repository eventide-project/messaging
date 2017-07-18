require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Reply" do
        message = Controls::Message.example

        reply_stream_name = message.metadata.reply_stream_name

        writer = Write::Substitute.build

        writer.reply(message)

        context "Replied Messages" do
          test "No block arguments" do
            assert(writer.message_replies.length == 1)
          end

          test "Message block argument only" do
            assert(writer.message_replies { |msg| msg == message }.length == 1 )
          end

          test "Message and stream name block arguments" do
            assert(writer.message_replies { |msg, stream| stream == reply_stream_name }.length == 1)
          end
        end
      end
    end
  end
end

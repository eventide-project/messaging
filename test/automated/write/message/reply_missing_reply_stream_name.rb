require_relative '../../automated_init'

context "Write" do
  context "Reply" do
    context "Missing Reply Stream Name" do
      message = Controls::Message.example
      message.metadata.reply_stream_name = nil

      reply_stream_name = Controls::StreamName.example(category: 'testReplyToMissingReplyStream')

      writer = Write.build

      test "Is an error" do
        assert proc { writer.reply(message) } do
          raises_error? Messaging::Write::Error
        end
      end
    end
  end
end

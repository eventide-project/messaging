require_relative '../../automated_init'

context "Write" do
  context "Reply" do
    context "Batch" do
      reply_stream_name = Controls::StreamName.example(category: 'testReplyToBatchError')

      message_1 = Controls::Message.example
      message_2 = Controls::Message.example

      batch = [message_1, message_2]

      write = Controls::Write.example

      test "Is an error" do
        assert_raises(Messaging::Write::Error) do
          write.reply(batch)
        end
      end
    end
  end
end

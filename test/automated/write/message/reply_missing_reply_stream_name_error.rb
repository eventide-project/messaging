require_relative '../../automated_init'

context "Write" do
  context "Reply" do
    context "Missing Reply Stream Name" do
      message = Controls::Message.example
      message.metadata.reply_stream_name = nil

      reply_stream_name = Controls::StreamName.example

      write = Write.build

      test "Is an error" do
        assert_raises(Messaging::Write::Error) do
          write.reply(message)
        end
      end
    end
  end
end

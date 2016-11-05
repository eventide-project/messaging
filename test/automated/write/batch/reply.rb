require_relative '../../automated_init'

context "Write" do
  context "Reply" do
    context "Batch" do
      reply_stream_name = Controls::StreamName.example

      message_1 = Controls::Message.example
      message_2 = Controls::Message.example

      batch = [message_1, message_2]

      writer = Messaging::Postgres::Write.build

      test "Is an error" do
        assert proc { writer.reply(batch) } do
          raises_error?
        end
      end
    end
  end
end

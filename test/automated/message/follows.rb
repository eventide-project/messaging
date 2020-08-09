require_relative '../automated_init'

context "Message" do
  context "Follows" do
    context "Metadata follows" do
      source_message = Controls::Message.example
      message = Controls::Message.example

      message.metadata.follow(source_message.metadata)

      assert(
        message.metadata.follows?(source_message.metadata)
      )

      test "Message follows" do
        assert(message.follows?(source_message))
      end
    end
  end
end

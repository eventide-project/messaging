require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Metadata" do
      source = Controls::Message.example

      context "Default" do
        receiver = source.class.new

        Message::Copy.(source, receiver, metadata: true)

        test "Metadata is copied" do
          assert(receiver.metadata == source.metadata)
        end
      end
    end
  end
end

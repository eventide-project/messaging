require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Strict" do
      context "Receiver has same attributes as the source" do
        source = Controls::Message.example
        receiver = source.class.new

        test "Is not an error" do
          refute_raises(Message::Copy::Error) do
            Message::Copy.(source, receiver, strict: true)
          end
        end
      end

      context "Receiver doesn't have all of the source's attributes" do
        source = Controls::Message.example
        receiver = Controls::Message::SingleAttribute.new

        test "Is an error" do
          assert_raises(Message::Copy::Error) do
            Message::Copy.(source, receiver, strict: true)
          end
        end
      end
    end
  end

  context "Not Strict (Default)" do
    context "Receiver doesn't have all of the source's attributes" do
      source = Controls::Message.example
      receiver = Controls::Message::SingleAttribute.new

      test "Is not an error" do
        refute_raises(Message::Copy::Error) do
          Message::Copy.(source, receiver)
        end
      end
    end
  end
end

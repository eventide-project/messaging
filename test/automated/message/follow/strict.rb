require_relative '../../automated_init'

context "Message" do
  context "Follow" do
    context "Strict (Default)" do
      context "Receiver has same attributes as the source" do
        source = Controls::Message.example
        receiver = source.class.new

        test "Is not an error" do
          refute_raises(Message::Copy::Error) do
            Message::Follow.(source, receiver)
          end
        end
      end

      context "Receiver doesn't have all of the source's attributes" do
        source = Controls::Message.example
        receiver = Controls::Message::SingleAttribute.new

        test "Is an error" do
          assert_raises(Message::Copy::Error) do
            Message::Follow.(source, receiver)
          end
        end
      end
    end
  end

  context "Not Strict" do
    context "Receiver doesn't have all of the source's attributes" do
      source = Controls::Message.example
      receiver = Controls::Message::SingleAttribute.new

      test "Is not an error" do
        refute_raises(Message::Copy::Error) do
          Message::Follow.(source, receiver, strict: false)
        end
      end
    end
  end
end

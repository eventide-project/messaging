require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Strict (Default)" do
      context "Receiver has same attributes as the source" do
        source = Controls::Message.example
        receiver = source.class.new

        test "No error" do
          Message::Copy.(source, receiver)
        end
      end

      context "Receiver doesn't have all of the source's attributes" do
        source = Controls::Message.example
        receiver = Controls::Message::SingleAttribute.new

        test "Is an error" do
          assert proc { Message::Copy.(source, receiver) } do
            raises_error? Message::Copy::Error
          end
        end
      end
    end
  end

  context "Not Strict" do
    context "Receiver doesn't have all of the source's attributes" do
      source = Controls::Message.example
      receiver = Controls::Message::SingleAttribute.new

      Message::Copy.(source, receiver, strict: false)

      test "Copies the attributes supported by the receiver" do
        assert(receiver.some_attribute == source.some_attribute)
      end
    end
  end
end

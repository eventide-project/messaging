require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Strict" do
      context "Receiver has same attributes as the source" do
        source = Controls::Message.example
        receiver = source.class.new

        test "Is not an error" do
          Message::Copy.(source, receiver, strict: true)
        end
      end

      context "Receiver doesn't have all of the source's attributes" do
        source = Controls::Message.example
        receiver = Controls::Message::SingleAttribute.new

        test "Is not an error" do
          assert proc { Message::Copy.(source, receiver, strict: true) } do
            raises_error? Message::Copy::Error
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
        refute proc { Message::Copy.(source, receiver) } do
          raises_error? Message::Copy::Error
        end
      end
    end
  end
end

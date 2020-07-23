require_relative '../../../automated_init'

context "Message" do
  context "Follow" do
    context "Secondary Forms" do
      context "Class Form" do
        source = Controls::Message.example

        context "Default" do
          receiver = Messaging::Message::Follow.(source, source.class)

          test "Message follows the preceding message" do
            assert(receiver.follows?(source))
          end

          test "Constructs the class" do
            assert(receiver.class == source.class)
          end

          test "Attributes are copied" do
            assert(receiver == source)
          end
        end
      end
    end
  end
end

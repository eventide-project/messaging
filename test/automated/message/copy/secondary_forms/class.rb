require_relative '../../../automated_init'

context "Message" do
  context "Copy" do
    context "Secondary Forms" do
      context "Class Form" do
        source = Controls::Message.example

        context "Default" do
          receiver = Messaging::Message::Copy.(source, source.class)

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

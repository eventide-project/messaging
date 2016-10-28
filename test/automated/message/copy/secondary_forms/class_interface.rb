require_relative '../../../automated_init'

context "Message" do
  context "Copy" do
    context "Secondary Forms" do
      context "Class Interface" do
        source = Controls::Message.example

        context "Default" do
          receiver = source.class.copy(source)

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

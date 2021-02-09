require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Default" do
        metadata = Messaging::Message::Metadata.new

        test "Array" do
          assert(metadata.properties == [])
        end
      end
    end
  end
end

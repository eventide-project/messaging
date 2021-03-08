require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Local Properties" do
      context "Default" do
        metadata = Messaging::Message::Metadata.new

        test "Hash" do
          assert(metadata.local_properties == {})
        end
      end
    end
  end
end

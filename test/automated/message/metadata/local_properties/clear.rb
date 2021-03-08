require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Local Properties" do
      context "Clear" do
        metadata = Messaging::Message::Metadata.new

        metadata.set_local_property(:some_local_property, 'some local_property value')
        metadata.set_local_property(:some_other_local_property, 'some other local_property value')

        assert(metadata.local_properties.count == 2)

        metadata.clear_local_properties

        test "All entries are removed" do
          assert(metadata.local_properties.empty?)
        end
      end
    end
  end
end

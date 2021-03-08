require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Clear" do
        metadata = Messaging::Message::Metadata.new

        metadata.set_property(:some_property, 'some property value')
        metadata.set_property(:some_other_property, 'some other property value')

        assert(metadata.properties.count == 2)

        metadata.clear_properties

        test "All entries are removed" do
          assert(metadata.properties.empty?)
        end
      end
    end
  end
end

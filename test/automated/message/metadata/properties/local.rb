require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Local" do
        context "Set" do
          metadata = Messaging::Message::Metadata.new

          name = :some_property
          value = 'some property value'

          metadata.set_property(name, value, local: true)

          property = metadata.properties[name]

          assert(property.value == value)

          test "Property is local" do
            assert(property.local?)
          end
        end

        context "Set Local Property" do
          metadata = Messaging::Message::Metadata.new

          name = :some_property
          value = 'some property value'

          metadata.set_local_property(name, value)

          property = metadata.properties[name]

          assert(property.value == value)

          test "Property is local" do
            assert(property.local?)
          end
        end
      end
    end
  end
end

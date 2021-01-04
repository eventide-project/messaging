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

      context "Set" do
        metadata = Messaging::Message::Metadata.new

        name = :some_property
        value = 'some property value'

        metadata.set_property(name, value)

        property = metadata.properties.find { |property| property.name == name }

        test "Value is in the properties hash" do
          assert(property.value == value)
        end
      end

      context "Get" do
        metadata = Messaging::Message::Metadata.new

        metadata.set_property(:some_property, 'some property value')

        value = metadata.get_property(:some_property)

        test "Value is retrieved from the properties hash" do
          assert(value == 'some property value')
        end
      end

      context "Delete" do
        metadata = Messaging::Message::Metadata.new

        metadata.set_property(:some_property, 'some property value')

        value = metadata.delete_property(:some_property)

        test "Entry is removed from the hash" do
          assert(metadata.get_property(:some_property).nil?)
        end

        test "Returns the entry's value" do
          assert(value == 'some property value')
        end
      end

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

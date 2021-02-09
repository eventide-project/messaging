require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Set" do
        context do
          metadata = Messaging::Message::Metadata.new

          name = "some_property"
          value = 'some property value'

          metadata.set_property(name, value)

          property = metadata.properties.find { |property| property.name == name }

          test "Value is in the properties hash" do
            assert(property.value == value)
          end
        end

        context "Non String Name" do
          metadata = Messaging::Message::Metadata.new

          name = :some_property
          value = 'some property value'

          test "Is an error" do
            assert_raises Message::Metadata::Error do
              metadata.set_property(name, value)
            end
          end
        end
      end
    end
  end
end

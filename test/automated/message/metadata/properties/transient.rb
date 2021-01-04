require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Transient" do
        context "Set" do
          metadata = Messaging::Message::Metadata.new

          name = :some_property
          value = 'some property value'

          metadata.set_property(name, value, transient: true)

          property = metadata.properties.find { |property| property.name == name }

          test "Property is transient" do
            assert(property.transient?)
          end
        end

        context "Set Transient Property" do
          metadata = Messaging::Message::Metadata.new

          name = :some_property
          value = 'some property value'

          metadata.set_transient_property(name, value)

          property = metadata.properties.find { |property| property.name == name }

          test "Property is transient" do
            assert(property.transient?)
          end
        end
      end
    end
  end
end

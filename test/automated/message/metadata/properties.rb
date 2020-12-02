require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Default" do
        metadata = Messaging::Message::Metadata.new

        test "Hash" do
          assert(metadata.properties == {})
        end
      end

      context "Set" do
        metadata = Messaging::Message::Metadata.new

        metadata.set_property(:some_property, 'some property value')

        test "Value is in the properties hash" do
          assert(metadata.properties[:some_property] == 'some property value')
        end
      end

      context "Get" do
        metadata = Messaging::Message::Metadata.new

        metadata.properties[:some_property] = 'some property value'

        value = metadata.get_property(:some_property)

        test "Value is retrieved from the properties hash" do
          assert(value == 'some property value')
        end
      end
    end
  end
end

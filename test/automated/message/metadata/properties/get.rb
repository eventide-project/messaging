require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Get" do
        context do
          metadata = Messaging::Message::Metadata.new

          metadata.set_property('some_property', 'some property value')

          value = metadata.get_property('some_property')

          test "Value is retrieved from the properties hash" do
            assert(value == 'some property value')
          end
        end

        context "Non String Name" do
          metadata = Messaging::Message::Metadata.new

          name = :some_property

          test "Is an error" do
            assert_raises Message::Metadata::Error do
              metadata.get_property(name)
            end
          end
        end
      end
    end
  end
end

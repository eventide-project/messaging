require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Local Properties" do
      context "Get" do
        context do
          metadata = Messaging::Message::Metadata.new

          metadata.set_local_property(:some_local_property, 'some local_property value')

          value = metadata.get_local_property(:some_local_property)

          test "Value is retrieved from the local_properties hash" do
            assert(value == 'some local_property value')
          end
        end

        context "Name Is Not a Symbol" do
          metadata = Messaging::Message::Metadata.new

          name = 'some_local_property'

          test "Is an error" do
            assert_raises Message::Metadata::Error do
              metadata.get_local_property(name)
            end
          end
        end
      end
    end
  end
end

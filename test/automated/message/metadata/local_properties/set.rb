require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Local Properties" do
      context "Set" do
        context do
          metadata = Messaging::Message::Metadata.new

          name = :some_local_property
          control_value = 'some local_property value'

          metadata.set_local_property(name, control_value)

          value = metadata.local_properties[name]

          test "Value is in the local_properties hash" do
            assert(value == control_value)
          end
        end

        context "Name Is Not a Symbol" do
          metadata = Messaging::Message::Metadata.new

          name = 'some_local_property'
          value = 'some local_property value'

          test "Is an error" do
            assert_raises Message::Metadata::Error do
              metadata.set_local_property(name, value)
            end
          end
        end
      end
    end
  end
end

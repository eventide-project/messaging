require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Local Properties" do
      context "Delete" do
        context do
          metadata = Messaging::Message::Metadata.new

          metadata.set_local_property(:some_local_property, 'some local_property value')

          value = metadata.delete_local_property(:some_local_property)

          test "Entry is removed from the hash" do
            assert(metadata.get_local_property(:some_local_property).nil?)
          end

          test "Returns the entry's value" do
            assert(value == 'some local_property value')
          end
        end

        context "Name Is Not a Symbol" do
          metadata = Messaging::Message::Metadata.new

          name = 'some_local_property'

          test "Is an error" do
            assert_raises Message::Metadata::Error do
              metadata.delete_local_property(name)
            end
          end
        end
      end
    end
  end
end

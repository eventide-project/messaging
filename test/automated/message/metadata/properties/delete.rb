require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Delete" do
        context do
          metadata = Messaging::Message::Metadata.new

          metadata.set_property('some_property', 'some property value')

          value = metadata.delete_property('some_property')

          test "Entry is removed from the hash" do
            assert(metadata.get_property('some_property').nil?)
          end

          test "Returns the entry's value" do
            assert(value == 'some property value')
          end
        end

        context "Non String Name" do
          metadata = Messaging::Message::Metadata.new

          name = :some_property

          test "Is an error" do
            assert_raises Message::Metadata::Error do
              metadata.delete_property(name)
            end
          end
        end
      end
    end
  end
end

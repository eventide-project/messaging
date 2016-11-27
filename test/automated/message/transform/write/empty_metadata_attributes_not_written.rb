require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Empty Metadata Attributes Not Written" do
      context "Data" do
        message = Controls::Message.example

        message.metadata.class.attribute_names.each do |metadata_attribute|
          message.metadata.send("#{metadata_attribute}=", nil)
        end

        event_data = Transform::Write.(message, :event_data)

        context "Metadata" do
          metadata = event_data.metadata

          test "EventData metadata has no fields" do
            assert(event_data.metadata.keys.empty?)
          end
        end
      end
    end
  end
end

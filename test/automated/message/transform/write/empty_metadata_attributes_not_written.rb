require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Empty Metadata Attributes Not Written" do
      context "Data" do
        message = Controls::Message.example

        message.metadata.class.attribute_names.each do |metadata_attribute|
          message.metadata.send("#{metadata_attribute}=", nil)
        end

        message_data = Transform::Write.(message, :message_data)

        context "Metadata" do
          metadata = message_data.metadata

          test "MessageData metadata has no fields" do
            assert(message_data.metadata.keys.empty?)
          end
        end
      end
    end
  end
end

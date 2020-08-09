require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Attribute Names" do
      context "Causation Attribute Names" do
        control_attribute_names = [
          :causation_message_stream_name,
          :causation_message_position,
          :causation_message_global_position
        ]

        attribute_names = Message::Metadata.causation_attribute_names

        detail "Control Attribute Names: #{control_attribute_names}"
        detail "Attribute Names: #{attribute_names}"

        test do
          assert(attribute_names == control_attribute_names)
        end
      end
    end
  end
end

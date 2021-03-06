require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Attribute Names" do
      context "Source Attribute Names" do
        control_attribute_names = [
          :stream_name,
          :position,
          :global_position
        ]

        attribute_names = Message::Metadata.source_attribute_names

        detail "Control Attribute Names: #{control_attribute_names}"
        detail "Attribute Names: #{attribute_names}"

        test do
          assert(attribute_names == control_attribute_names)
        end
      end
    end
  end
end

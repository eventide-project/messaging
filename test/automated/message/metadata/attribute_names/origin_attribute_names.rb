require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Attribute Names" do
      context "Origin Attribute Names" do
        control_attribute_names = [
          :correlation_stream_name,
          :reply_stream_name
        ]

        attribute_names = Message::Metadata.origin_attribute_names

        detail "Control Attribute Names: #{control_attribute_names}"
        detail "Attribute Names: #{attribute_names}"

        test do
          assert(attribute_names == control_attribute_names)
        end
      end
    end
  end
end

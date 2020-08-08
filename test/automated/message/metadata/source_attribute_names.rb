require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Source Attribute Names" do
      control_source_attribute_names = [:stream_name, :position, :global_position]
      source_attribute_names = Message::Metadata.source_attributes

      test do
        assert(source_attribute_names == source_attribute_names)
      end
    end
  end
end

require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Metadata" do
      source = Controls::Message.example

      context "Default" do
        receiver = source.class.new

        detail "Metadata (Prior to Copy: #{receiver.metadata.pretty_inspect}"

        Message::Copy.(source, receiver, metadata: true)

        metadata = receiver.metadata
        source_metadata = source.metadata

        detail "Metadata: #{metadata.pretty_inspect}"
        detail "Source Metadata: #{source_metadata.pretty_inspect}"

        test "Copied" do
          assert(metadata == source_metadata)
        end

        context "Properties" do
          properties = metadata.properties
          source_properties = source_metadata.properties

          test "List object reference is duplicated" do
            refute(properties.object_id == source_properties.object_id)
          end

          context "Property object references are duplicated" do
            properties.each do |property|
              source_property = source_metadata.get_property(property.name)

              test do
                refute(property.object_id == source_property.object_id)
              end
            end
          end
        end
      end
    end
  end
end

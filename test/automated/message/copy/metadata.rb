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

          test "Hash object is duplicated" do
            refute(properties.object_id == source_properties.object_id)
          end
        end

        context "Local Properties" do
          local_properties = metadata.local_properties
          source_local_properties = source_metadata.local_properties

          test "Hash object is duplicated" do
            refute(local_properties.object_id == source_local_properties.object_id)
          end
        end
      end
    end
  end
end

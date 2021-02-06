require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follow" do
      context "Local Properties" do
        source = Controls::Message.example(metadata: Controls::Metadata::Random.example)

        receiver = source.class.new

        source_metadata = source.metadata
        metadata = receiver.metadata

        source_metadata.set_property(:some_property, 'some value')
        source_metadata.set_local_property(:some_local_property, 'some local value')

        metadata.follow(source_metadata)

        detail "Source Metadata: #{source_metadata.pretty_inspect}"
        detail "Following Metadata: #{metadata.pretty_inspect}"

        local_properties = metadata.properties.select { |property| property.local? }

        detail "Following Local Properties: #{local_properties.pretty_inspect}"

        context "Not Copied" do
          test do
            assert(local_properties.empty?)
          end
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Message" do
  context "Follow" do
    context "Transient Properties" do
      source = Controls::Message.example(metadata: Controls::Metadata::Random.example)

      receiver = source.class.new

      source_metadata = source.metadata
      metadata = receiver.metadata

      source_metadata.set_property(:some_property, "some value")
      source_metadata.set_transient_property(:some_transient_property, "some transient value")

      Message::Follow.(source, receiver)

      detail "Source Metadata: #{source_metadata.pretty_inspect}"
      detail "Following Metadata: #{metadata.pretty_inspect}"

      transient_properties = metadata.properties.select { |property| property.transient? }

      detail "Following Transient Properties: #{transient_properties.pretty_inspect}"

      context "Not Copied" do
        test do
          assert(transient_properties.empty?)
        end
      end
    end
  end
end

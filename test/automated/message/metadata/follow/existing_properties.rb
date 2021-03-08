require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follow" do
      context "Existing Properties" do
        source_metadata = Controls::Metadata.example
        metadata = Message::Metadata.new

        source_properties = source_metadata.properties
        refute(source_properties[:some_property].nil?)

        metadata.set_property(:some_property, "some value that will be overridden")
        control_some_other_property_value = "some other value"
        metadata.set_property(:some_other_property, control_some_other_property_value)

        refute(metadata.properties[:some_property] == source_properties[:some_property])

        metadata.follow(source_metadata)

        detail "Source Metadata:\n#{source_metadata.all_attributes.pretty_inspect}"
        detail "Metadata:\n#{metadata.all_attributes.pretty_inspect}"

        properties = metadata.properties

        detail "Properties: #{properties.pretty_inspect}"
        detail "Source Properties: #{source_properties.pretty_inspect}"

        context "Present in Source and Receiver" do
          property = properties[:some_property]
          source_property = source_properties[:some_property]

          test "Overwritten" do
            assert(property == source_property)
          end
        end

        context "Present in Receiver Only" do
          property = properties[:some_other_property]

          test "Unchanged" do
            assert(property == control_some_other_property_value)
          end
        end
      end
    end
  end
end

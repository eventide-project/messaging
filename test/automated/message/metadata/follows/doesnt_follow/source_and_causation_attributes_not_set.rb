require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Doesn't Follow" do
        context "Source and Causation Attributes Not Set" do
          detail "Map of source attribute to causation attribute where both values are nil"
          Pair = Struct.new(:source_attribute, :receiver_attribute)

          attribute_pairs = [
            Pair.new(:stream_name, :causation_message_stream_name),
            Pair.new(:position, :causation_message_position),
            Pair.new(:global_position, :causation_message_global_position)
          ]

          attribute_pairs.each do |pair|
            source_metadata = Controls::Metadata::Random.example
            metadata = Controls::Metadata::Random.example

            metadata.follow(source_metadata)

            source_attribute = pair.source_attribute
            receiver_attribute = pair.receiver_attribute

            source_metadata.send("#{source_attribute}=", nil)
            metadata.send("#{receiver_attribute}=", nil)

            detail "Source Metadata:\n#{source_metadata.all_attributes.pretty_inspect}"
            detail "Metadata:\n#{metadata.all_attributes.pretty_inspect}"

            context "#{source_attribute}, #{receiver_attribute}" do
              detail "Source Value: #{source_metadata.send(source_attribute).inspect}"
              detail "Value: #{metadata.send(receiver_attribute).inspect}"

              test "Doesn't follow" do
                refute(metadata.follows?(source_metadata))
              end
            end
          end
        end
      end
    end
  end
end

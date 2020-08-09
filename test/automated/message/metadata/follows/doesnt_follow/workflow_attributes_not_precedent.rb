require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Doesn't Follow" do
        context "Workflow Attributes Not Precedent" do
          source_metadata = Controls::Metadata::Random.example

          AttributeValue = Struct.new(:name, :value)

          attribute_values = [
            AttributeValue.new(:causation_message_stream_name, SecureRandom.hex),
            AttributeValue.new(:causation_message_position, Controls::Random::Number.example),
            AttributeValue.new(:causation_message_global_position, Controls::Random::Number.example),
            AttributeValue.new(:reply_stream_name, SecureRandom.hex)
          ]

          attribute_values.each do |attribute_value|
            attribute = attribute_value.name
            value = attribute_value.value

            context "#{attribute}" do
              metadata = Controls::Metadata::Random.example

              metadata.follow(source_metadata)

              assert(metadata.follows?(source_metadata))

              metadata.send("#{attribute}=", value)

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

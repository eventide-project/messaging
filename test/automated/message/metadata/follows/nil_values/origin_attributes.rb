require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Nil Values" do
      context "Origin Attributes" do
        Pair = Struct.new(:source_attribute, :receiver_attribute)

        attribute_pairs = [
          Pair.new(:stream_name, :causation_message_stream_name),
          Pair.new(:position, :causation_message_position),
          Pair.new(:global_position, :causation_message_global_position)
        ]

        context "Any Pair of Workflow Attributes Where Both Values Are Nil" do
          attribute_pairs.each do |pair|
            source_metadata = Controls::Metadata::Random.example
            metadata = Controls::Metadata::Random.example

            metadata.causation_message_stream_name = source_metadata.stream_name
            metadata.causation_message_position = source_metadata.position
            metadata.causation_message_global_position = source_metadata.global_position
            metadata.reply_stream_name = source_metadata.reply_stream_name

            source_attribute = pair.source_attribute
            receiver_attribute = pair.receiver_attribute

            source_metadata.send "#{source_attribute}=", nil
            metadata.send "#{receiver_attribute}=", nil

            context "#{source_attribute}, #{receiver_attribute}" do
              refute(metadata.follows?(source_metadata))
            end
          end
        end
      end
    end
  end
end

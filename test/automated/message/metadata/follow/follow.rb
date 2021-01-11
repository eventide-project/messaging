require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follow" do
      source_metadata = Controls::Metadata.example
      metadata = Message::Metadata.new

      # source_metadata.set_property(:some_property, "some property value")

      refute(source_metadata.stream_name.nil?)
      refute(source_metadata.position.nil?)
      refute(source_metadata.global_position.nil?)
      refute(source_metadata.correlation_stream_name.nil?)
      refute(source_metadata.reply_stream_name.nil?)
      refute(source_metadata.properties.empty?)

      refute(metadata.causation_message_stream_name == source_metadata.stream_name)
      refute(metadata.causation_message_position == source_metadata.position)
      refute(metadata.causation_message_global_position == source_metadata.global_position)
      refute(metadata.correlation_stream_name == source_metadata.correlation_stream_name)
      refute(metadata.reply_stream_name == source_metadata.reply_stream_name)

      metadata.follow(source_metadata)

      detail "Source Metadata:\n#{source_metadata.all_attributes.pretty_inspect}"
      detail "Metadata:\n#{metadata.all_attributes.pretty_inspect}"

      context "Copied from Source Metadata" do
        context "causation_message_stream_name" do
          test "Set from stream_name" do
            assert(metadata.causation_message_stream_name == source_metadata.stream_name)
          end
        end

        context "causation_message_position" do
          test "Set from position" do
            assert(metadata.causation_message_position == source_metadata.position)
          end
        end

        context "causation_message_global_position" do
          test "Set from global_position" do
            assert(metadata.causation_message_global_position == source_metadata.global_position)
          end
        end

        test "correlation_stream_name" do
          assert(metadata.correlation_stream_name == source_metadata.correlation_stream_name)
        end

        test "reply_stream_name" do
          assert(metadata.reply_stream_name == source_metadata.reply_stream_name)
        end

        context "properties" do
          assert(metadata.properties.length == 1)

          property = metadata.properties.first
          source_property = source_metadata.properties.first

          test do
            assert(property == source_property)
          end
        end
      end

      context "Not Copied from Source Metadata" do
        unchanged_metadata = Message::Metadata.new

        [
          :stream_name,
          :position,
          :global_position,
          :time,
          :schema_version
        ].each do |attribute|
          test attribute.to_s do
            assert(metadata.public_send(attribute) == unchanged_metadata.public_send(attribute))
          end
        end
      end
    end
  end
end

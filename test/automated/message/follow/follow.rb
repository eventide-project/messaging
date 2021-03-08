require_relative '../../automated_init'

context "Message" do
  context "Follow" do
    source = Controls::Message.example(metadata: Controls::Metadata::Random.example)

    receiver = source.class.new

    source_metadata = source.metadata
    metadata = receiver.metadata

    refute(source_metadata.stream_name.nil?)
    refute(source_metadata.position.nil?)
    refute(source_metadata.global_position.nil?)
    refute(source_metadata.correlation_stream_name.nil?)
    refute(source_metadata.reply_stream_name.nil?)

    source_properties = source_metadata.properties
    refute(source_properties[:some_property].nil?)

    source_local_properties = source_metadata.local_properties
    refute(source_local_properties[:some_local_property].nil?)

    refute(metadata.causation_message_stream_name == source_metadata.stream_name)
    refute(metadata.causation_message_position == source_metadata.position)
    refute(metadata.causation_message_global_position == source_metadata.global_position)
    refute(metadata.correlation_stream_name == source_metadata.correlation_stream_name)
    refute(metadata.reply_stream_name == source_metadata.reply_stream_name)

    Message::Follow.(source, receiver)

    test "Attributes are copied" do
      assert(receiver == source)
    end

    context "Metadata" do
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

        context "Properties" do
          properties = metadata.properties
          source_properties = source_metadata.properties

          detail "Properties: #{properties.pretty_inspect}"
          detail "Source Properties: #{source_properties.pretty_inspect}"

          context "Copied" do
            property = metadata.get_property(:some_property)
            source_property = source_metadata.get_property(:some_property)

            test do
              assert(property == source_property)
            end
          end

          context "Object References" do
            test "Hash object is duplicated" do
              refute(properties.object_id == source_properties.object_id)
            end
          end
        end

        context "Local Properties" do
          local_properties = metadata.local_properties

          test "Omitted" do
            assert(local_properties.empty?)
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

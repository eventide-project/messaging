require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follow" do
      source_metadata = Controls::Metadata.example
      metadata = Controls::Metadata.example

      metadata.follow(source_metadata)

      context "Workflow attributes are copied" do
        test "Causation event stream name is set to the preceding source event stream name" do
          assert(metadata.causation_event_stream_name = source_metadata.source_event_stream_name)
        end

        test "Causation event position is set to the preceding source event position" do
          assert(metadata.causation_event_position = source_metadata.source_event_position)
        end
      end
    end
  end

  context "Non workflow attributes are unchanged" do
    source_metadata = Controls::Metadata.example
    metadata = Controls::Metadata.example
    unchanged_metadata = Controls::Metadata.example

    metadata.follow(source_metadata)

    [:source_event_stream_name, :source_event_position, :correlation_stream_name, :reply_stream_name].each do |attribute|
      test attribute.to_s do
        assert(metadata.public_send(attribute) == unchanged_metadata.public_send(attribute))
      end
    end
  end
end

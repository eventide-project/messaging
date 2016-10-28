require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Workflow attributes are equal" do
        source_metadata = Controls::Metadata.example
        metadata = Controls::Metadata.example

        metadata.causation_event_stream_name = source_metadata.source_event_stream_name
        metadata.causation_event_position = source_metadata.source_event_position
        metadata.correlation_stream_name == source_metadata.correlation_stream_name &&
        metadata.reply_stream_name == source_metadata.reply_stream_name

        test "Metadata follows the precedent" do
          assert(metadata.follows?(source_metadata))
        end
      end
    end
  end

  context "Doesn't Follow" do
    source_metadata = Controls::Metadata.example

    context "Any workflow attribute isn't equal" do
      [:causation_event_stream_name, :causation_event_position, :correlation_stream_name, :reply_stream_name].each do |attribute|
        metadata = Controls::Metadata.example

        metadata.causation_event_stream_name = source_metadata.source_event_stream_name
        metadata.causation_event_position = source_metadata.source_event_position

        metadata.send "#{attribute}=", SecureRandom.hex

        test attribute.to_s do
          refute(metadata.follows?(source_metadata))
        end
      end
    end
  end
end

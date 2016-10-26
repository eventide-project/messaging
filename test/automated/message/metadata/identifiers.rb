require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Identifiers" do
      metadata = Controls::Metadata.example

      context "Source Event" do
        source_event_identifier = metadata.source_event_identifier
        source_event_identifier_control = Controls::Metadata.source_event_identifier

        test "Join of stream name and position" do
          assert(source_event_identifier == source_event_identifier_control)
        end
      end

      context "Causation Event" do
        causation_event_identifier = metadata.causation_event_identifier
        causation_event_identifier_control = Controls::Metadata.causation_event_identifier

        test "Join of stream name and position" do
          assert(causation_event_identifier == causation_event_identifier_control)
        end
      end
    end
  end
end

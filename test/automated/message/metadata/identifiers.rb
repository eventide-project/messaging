require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Identifiers" do
      metadata = Controls::Metadata.example

      context "Source Message" do
        source_message_identifier = metadata.source_message_identifier
        source_message_identifier_control = Controls::Metadata.source_message_identifier

        test "Join of stream name and position" do
          assert(source_message_identifier == source_message_identifier_control)
        end
      end

      context "Causation Message" do
        causation_message_identifier = metadata.causation_message_identifier
        causation_message_identifier_control = Controls::Metadata.causation_message_identifier

        test "Join of stream name and position" do
          assert(causation_message_identifier == causation_message_identifier_control)
        end
      end
    end
  end
end

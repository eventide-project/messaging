require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Source Event Identifier" do
      context "Source Fields" do
        context "Set" do
          metadata = Controls::Metadata.example

          causation_event_identifier = metadata.causation_event_identifier
          causation_event_identifier_control = Controls::Metadata.causation_event_identifier

          test "Join of stream name and position" do
            assert(causation_event_identifier == causation_event_identifier_control)
          end
        end

        context "Not Set" do
          [:causation_event_stream_name, :causation_event_position].each do |attribute|
            metadata = Controls::Metadata.example

            context "#{attribute}" do
              metadata.public_send("#{attribute}=", nil)

              causation_event_identifier = metadata.causation_event_identifier

              test "Identifier is nil" do
                assert(causation_event_identifier.nil?)
              end
            end
          end
        end
      end
    end
  end
end

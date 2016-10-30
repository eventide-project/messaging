require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Source Event Identifier" do
      context "Source Fields" do
        context "Set" do
          metadata = Controls::Metadata.example

          source_event_identifier = metadata.source_event_identifier
          source_event_identifier_control = Controls::Metadata.source_event_identifier

          test "Join of stream name and position" do
            assert(source_event_identifier == source_event_identifier_control)
          end
        end

        context "Not Set" do
          [:source_event_stream_name, :source_event_position].each do |attribute|
            metadata = Controls::Metadata.example

            context "#{attribute}" do
              metadata.public_send("#{attribute}=", nil)

              source_event_identifier = metadata.source_event_identifier

              test "Identifier is nil" do
                assert(source_event_identifier.nil?)
              end
            end
          end
        end
      end
    end
  end
end

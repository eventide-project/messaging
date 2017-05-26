require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Source Message Identifier" do
      context "Source Fields" do
        context "Set" do
          metadata = Controls::Metadata.example

          causation_message_identifier = metadata.causation_message_identifier
          causation_message_identifier_control = Controls::Metadata.causation_message_identifier

          test "Join of stream name and position" do
            assert(causation_message_identifier == causation_message_identifier_control)
          end
        end

        context "Not Set" do
          [:causation_message_stream_name, :causation_message_position].each do |attribute|
            metadata = Controls::Metadata.example

            context "#{attribute}" do
              metadata.public_send("#{attribute}=", nil)

              causation_message_identifier = metadata.causation_message_identifier

              test "Identifier is nil" do
                assert(causation_message_identifier.nil?)
              end
            end
          end
        end
      end
    end
  end
end

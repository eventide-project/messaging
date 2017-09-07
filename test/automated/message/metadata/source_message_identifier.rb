require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Source Message Identifier" do
      context "Source Fields" do
        context "Set" do
          metadata = Controls::Metadata.example

          source_message_identifier = metadata.source_message_identifier
          source_message_identifier_control = Controls::Metadata.source_message_identifier

          test "Join of stream name and position" do
            assert(source_message_identifier == source_message_identifier_control)
          end
        end

        context "Not Set" do
          [:stream_name, :position].each do |attribute|
            metadata = Controls::Metadata.example

            context "#{attribute}" do
              metadata.public_send("#{attribute}=", nil)

              source_message_identifier = metadata.source_message_identifier

              test "Identifier is nil" do
                assert(source_message_identifier.nil?)
              end
            end
          end
        end
      end
    end
  end
end

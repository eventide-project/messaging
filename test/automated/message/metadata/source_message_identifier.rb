require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Source Message Identifier" do
      context "Source Fields" do
        context "Set" do
          metadata = Controls::Metadata.example

          identifier = metadata.identifier
          identifier_control = Controls::Metadata.identifier

          test "Join of stream name and position" do
            assert(identifier == identifier_control)
          end
        end

        context "Not Set" do
          [:stream_name, :position].each do |attribute|
            metadata = Controls::Metadata.example

            context "#{attribute}" do
              metadata.public_send("#{attribute}=", nil)

              identifier = metadata.identifier

              test "Identifier is nil" do
                assert(identifier.nil?)
              end
            end
          end
        end
      end
    end
  end
end

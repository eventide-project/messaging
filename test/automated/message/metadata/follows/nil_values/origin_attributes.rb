require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Nil Values" do
        context "Origin Attributes" do
          context "Source Value is Not Set" do
            metadata = Controls::Metadata::Random.example

            Message::Metadata.origin_attributes.each do |attribute|
              source_metadata = Controls::Metadata::Random.example

              metadata.follow(source_metadata)

              assert(metadata.follows?(source_metadata))

              value = metadata.send(attribute)
              refute(value.nil?)

              source_metadata.send("#{attribute}=", nil)

              context "#{attribute}" do
                detail "Source Metadata:\n#{source_metadata.all_attributes.pretty_inspect}"
                detail "Metadata:\n#{metadata.all_attributes.pretty_inspect}"

                test "Follows" do
                  assert(metadata.follows?(source_metadata))
                end
              end
            end
          end
        end
      end
    end
  end
end

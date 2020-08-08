require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      source_metadata = Controls::Metadata::Random.example

      context "Any Workflow Attribute Isn't Precedent" do
        [:causation_message_stream_name, :reply_stream_name].each do |attribute|
          context "#{attribute}" do
            metadata = Controls::Metadata::Random.example

            metadata.follow(source_metadata)

            assert(metadata.follows?(source_metadata))

            metadata.send "#{attribute}=", SecureRandom.hex

            test "Doesn't follow" do
              refute(metadata.follows?(source_metadata))
            end
          end
        end

        context "causation_message_position" do
          metadata = Controls::Metadata::Random.example

          metadata.follow(source_metadata)

          assert(metadata.follows?(source_metadata))

          metadata.causation_message_position = Controls::Random::Number.example

          test "Doesn't follow" do
            refute(metadata.follows?(source_metadata))
          end
        end

        context "causation_message_global_position" do
          metadata = Controls::Metadata::Random.example

          metadata.follow(source_metadata)

          assert(metadata.follows?(source_metadata))

          metadata.causation_message_global_position = Controls::Random::Number.example

          test "Doesn't follow" do
            refute(metadata.follows?(source_metadata))
          end
        end
      end
    end
  end
end

require_relative '../../../automated_init'

context "Message" do
  context "Follows" do
    context "Exclude" do
      context "Single Attributes" do
        [:causation_message_stream_name, :reply_stream_name].each do |attribute|
          source_metadata = Controls::Metadata::Random.example
          metadata = Controls::Metadata::Random.example

          metadata.follow(source_metadata)

          metadata.send "#{attribute}=", SecureRandom.hex

          test attribute.to_s do
            assert(metadata.follows?(source_metadata, exclude: attribute))
          end
        end

        test "causation_message_position" do
          source_metadata = Controls::Metadata::Random.example
          metadata = Controls::Metadata::Random.example

          metadata.follow(source_metadata)

          metadata.causation_message_position = Controls::Random::Number.example

          assert(metadata.follows?(source_metadata, exclude: :causation_message_position))
        end

        test "causation_message_global_position" do
          source_metadata = Controls::Metadata::Random.example
          metadata = Controls::Metadata::Random.example

          metadata.follow(source_metadata)

          metadata.causation_message_global_position = Controls::Random::Number.example

          assert(metadata.follows?(source_metadata, exclude: :causation_message_global_position))
        end
      end
    end
  end
end

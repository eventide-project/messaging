require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      source_metadata = Controls::Metadata::Random.example
      metadata = Controls::Metadata::Random.example

      metadata.follow(source_metadata)

      test "Metadata follows" do
        assert(metadata.follows?(source_metadata))
      end
    end
  end
end

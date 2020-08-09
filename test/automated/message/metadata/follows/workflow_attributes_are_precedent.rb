require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Follows" do
      context "Workflow Attributes Are Precedent" do
        source_metadata = Controls::Metadata::Random.example
        metadata = Controls::Metadata::Random.example

        refute(source_metadata.stream_name.nil?)
        refute(source_metadata.position.nil?)
        refute(source_metadata.global_position.nil?)
        refute(source_metadata.correlation_stream_name.nil?)
        refute(source_metadata.reply_stream_name.nil?)

        refute(metadata.causation_message_stream_name == source_metadata.stream_name)
        refute(metadata.causation_message_position == source_metadata.position)
        refute(metadata.causation_message_global_position == source_metadata.global_position)
        refute(metadata.correlation_stream_name == source_metadata.correlation_stream_name)
        refute(metadata.reply_stream_name == source_metadata.reply_stream_name)


        metadata.causation_message_stream_name = source_metadata.stream_name
        metadata.causation_message_position = source_metadata.position
        metadata.causation_message_global_position = source_metadata.global_position
        metadata.correlation_stream_name = source_metadata.correlation_stream_name
        metadata.reply_stream_name = source_metadata.reply_stream_name


        detail "Source Metadata:\n#{source_metadata.all_attributes.pretty_inspect}"
        detail "Metadata:\n#{metadata.all_attributes.pretty_inspect}"

        test "Metadata follows the precedent" do
          assert(metadata.follows?(source_metadata))
        end
      end
    end
  end
end

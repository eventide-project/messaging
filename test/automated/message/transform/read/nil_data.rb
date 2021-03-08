require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Read" do
      context "Nil Data" do
        type = Controls::Message.type
        metadata = Controls::Metadata::Written.data

        data = :none

        message_data = Controls::MessageData::Read.example(type: type, data: data, metadata: metadata)

        message = Transform::Read.(message_data, :message_data, Controls::Message::SomeMessage)

        detail "MessageData: #{message_data.pretty_inspect}"
        detail "Message: #{message.pretty_inspect}"

        context "Message Data" do
          test "Attributes" do
            assert(message.attributes.values.each { |value| value.nil? })
          end

          context "Metadata" do
            metadata = message.metadata

            test "stream_name" do
              assert(metadata.stream_name == message_data.stream_name)
            end

            test "source_message_stream_position" do
              assert(metadata.position == message_data.position)
            end

            test "global_position" do
              assert(metadata.global_position == message_data.global_position)
            end

            test "time" do
              assert(metadata.time == message_data.time)
            end

            test "schema_version" do
              assert(metadata.schema_version == message_data.metadata[:schema_version])
            end

            test "causation_message_stream_name" do
              assert(metadata.causation_message_stream_name == message_data.metadata[:causation_message_stream_name])
            end

            test "causation_message_position" do
              assert(metadata.causation_message_position == message_data.metadata[:causation_message_position])
            end

            test "causation_message_global_position" do
              assert(metadata.causation_message_global_position == message_data.metadata[:causation_message_global_position])
            end

            test "correlation_stream_name" do
              assert(metadata.correlation_stream_name == message_data.metadata[:correlation_stream_name])
            end

            test "properties" do
              assert(metadata.properties == message_data.metadata[:properties])
            end

            test "reply_stream_name" do
              assert(metadata.reply_stream_name == message_data.metadata[:reply_stream_name])
            end
          end
        end
      end
    end
  end
end

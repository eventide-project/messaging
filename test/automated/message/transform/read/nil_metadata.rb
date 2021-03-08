require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Read" do
      context "Nil Metadata" do
        type = Controls::Message.type
        data = Controls::Message.data

        metadata = :none

        message_data = Controls::MessageData::Read.example(type: type, data: data, metadata: metadata)

        message = Transform::Read.(message_data, :message_data, Controls::Message::SomeMessage)

        detail "MessageData: #{message_data.pretty_inspect}"
        detail "Message: #{message.pretty_inspect}"

        context "Message Data" do
          test "Attributes" do
            assert(message.to_h == data)
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

            context "properties" do
              test "Is a hash" do
                assert(metadata.properties.is_a?(Hash))
              end

              test "Is empty" do
                assert(metadata.properties.empty?)
              end
            end

            context "Nil attributes" do
              test "causation_message_stream_name" do
                assert(metadata.causation_message_stream_name.nil?)
              end

              test "causation_message_position" do
                assert(metadata.causation_message_position.nil?)
              end

              test "causation_message_global_position" do
                assert(metadata.causation_message_global_position.nil?)
              end

              test "correlation_stream_name" do
                assert(metadata.correlation_stream_name.nil?)
              end

              test "reply_stream_name" do
                assert(metadata.reply_stream_name.nil?)
              end

              test "schema_version" do
                assert(metadata.schema_version.nil?)
              end
            end
          end
        end
      end
    end
  end
end

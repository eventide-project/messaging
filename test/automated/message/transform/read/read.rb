require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Read" do
      type = Controls::Message.type
      data = Controls::Message.data
      metadata = Controls::Metadata::Written.data

      event_data = Controls::EventData::Read.example(type: type, data: data, metadata: metadata)

      message = Transform::Read.(event_data, :event_data, Controls::Message::SomeMessage)

      context "Message Data" do
        test "Attributes" do
          assert(message.to_h == event_data.data)
        end

        context "Metadata" do
          metadata = message.metadata

          test "source_event_stream_name" do
            assert(metadata.source_event_stream_name = event_data.stream_name)
          end

          test "source_event_stream_position" do
            assert(metadata.source_event_position = event_data.position)
          end

          test "global_position" do
            assert(metadata.global_position = event_data.global_position)
          end

          test "time" do
            assert(metadata.time = event_data.time)
          end

          test "schema_version" do
            assert(metadata.schema_version = event_data.metadata[:schema_version])
          end

          test "causation_event_stream_name" do
            assert(metadata.causation_event_stream_name = event_data.metadata[:causation_event_stream_name])
          end

          test "causation_event_position" do
            assert(metadata.causation_event_position = event_data.metadata[:causation_event_position])
          end

          test "correlation_stream_name" do
            assert(metadata.correlation_stream_name = event_data.metadata[:correlation_stream_name])
          end

          test "reply_stream_name" do
            assert(metadata.reply_stream_name = event_data.metadata[:reply_stream_name])
          end
        end
      end
    end
  end
end

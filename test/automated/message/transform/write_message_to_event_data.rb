require_relative '../../automated_init'

context "Message" do
  context "Transform" do
    context "Write Message to EventData" do
      context "Data" do
        message = Controls::Message.example

        event_data = Transform::Write.(message, :event_data)

        test "Type is the message's message type" do
          assert(event_data.type == 'SomeMessage')
        end

        test "Data is the message's data" do
          data = Controls::Message.data
          assert(event_data.data == data)
        end

        context "Metadata" do
          metadata = event_data.metadata

          test "source_event_stream_name is omitted from the metadata" do
            assert(metadata[:source_event_stream_name].nil?)
          end

          test "source_event_position is omitted from the metadata" do
            assert(metadata[:source_event_position].nil?)
          end

          test "causation_event_stream_name" do
            assert(metadata[:causation_event_stream_name] == message.metadata.causation_event_stream_name)
          end

          test "causation_event_position" do
            assert(metadata[:causation_event_position] == message.metadata.causation_event_position)
          end

          test "correlation_stream_name" do
            assert(metadata[:correlation_stream_name] == message.metadata.correlation_stream_name)
          end

          test "reply_stream_name" do
            assert(metadata[:reply_stream_name] == message.metadata.reply_stream_name)
          end

          test "global_position" do
            assert(metadata[:global_position] == message.metadata.global_position)
          end

          test "time" do
            assert(metadata[:time] == message.metadata.time)
          end

          test "schema_version" do
            assert(metadata[:schema_version] == message.metadata.schema_version)
          end
        end
      end

      context "Empty Message Metadata" do
        metadata = Controls::Metadata::Empty.example
        message = Controls::Message.example(metadata: metadata)

        event_data = Transform::Write.(message, :event_data)

        test "EventData metadata has no fields" do
          assert(event_data.metadata.keys.empty?)
        end
      end
    end
  end
end

require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Write" do
      context "Data" do
        message = Controls::Message.example

        event_data = Transform::Write.(message, :event_data)

        test "ID" do
          assert(event_data.id == message.id)
        end

        test "Type is the message's message type" do
          assert(event_data.type == 'SomeMessage')
        end

        test "Data is the message's data" do
          data = Controls::Message.data
          assert(event_data.data == data)
        end

        context "Metadata" do
          metadata = event_data.metadata

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

          test "schema_version" do
            assert(metadata[:schema_version] == message.metadata.schema_version)
          end

          context "Transient Attributes" do
            ::Messaging::Message::Metadata.transient_attributes.each do |transient_attribute|
              test "#{transient_attribute} is omitted from the metadata" do
                assert(metadata[transient_attribute].nil?)
              end
            end
          end
        end
      end
    end
  end
end

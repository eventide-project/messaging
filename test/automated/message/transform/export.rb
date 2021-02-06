require_relative '../../automated_init'

context "Message" do
  context "Export" do
    message = Controls::Message.example

    message_data = Message::Export.(message)

    detail "Message: #{message.pretty_inspect}"
    detail "MessageData: #{message_data.pretty_inspect}"

    context "Message is exported to MessageData" do
      test "MessageData type is Message's type" do
        assert(message.message_type == message_data.type)
      end

      test "MessageData's attributes are equal to the message's attributes" do
        assert(message_data.data == message.to_h)
      end

      context "MessageData's metadata attributes are equal to the message's metadata attributes" do
        [
          :causation_message_stream_name,
          :causation_message_position,
          :causation_message_global_position,
          :correlation_stream_name,
          :reply_stream_name,
          :schema_version
        ].each do |attribute|
          test "#{attribute}" do
            assert(message.metadata.send(attribute) == message_data.metadata[attribute])
          end
        end

        context "properties" do
          message_properties = message.metadata.properties
          message_data_properties = message_data.metadata[:properties]

          message_properties.length.times do |i|
            message_property = message_properties[i]
            message_data_property = message_data_properties[i]

            test "name" do
              assert(message_data_property[:name] == message_property.name)
            end

            test "value" do
              assert(message_data_property[:value] == message_property.value)
            end

            test "local" do
              assert(!!message_data_property[:local] == !!message_property.local)
            end
          end
        end
      end
    end
  end
end

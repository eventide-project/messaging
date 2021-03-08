require_relative '../../automated_init'

context "Message" do
  type = Controls::Message.type
  metadata = Controls::Metadata::Written.data
  data = Controls::Message.data

  message_data = Controls::MessageData::Read.example(type: type, data: data, metadata: metadata)

  context "Import" do
    message = Message::Import.(message_data, Controls::Message::SomeMessage)

    detail "MessageData: #{message_data.pretty_inspect}"
    detail "Message: #{message.pretty_inspect}"

    context "MessageData imported into message" do
      test "Message's type is the MessageData type" do
        assert(message.message_type == message_data.type)
      end

      test "Message's attributes are equal to the message data's attributes" do
        assert(message.to_h == message_data.data)
      end

      context "Metadata" do
        context "Attributes" do
          [
            :causation_message_stream_name,
            :causation_message_position,
            :causation_message_global_position,
            :correlation_stream_name,
            :reply_stream_name,
            :schema_version,
            :properties,
            :local_properties
          ].each do |attribute|
            test "#{attribute}" do
              assert(message.metadata.send(attribute) == message_data.metadata[attribute])
            end
          end
        end
      end
    end
  end

  context "MessageData type is not the message's type" do
    test "Is an error" do
      assert_raises(Message::Import::Error) do
        Message::Import.(message_data, Controls::Message::OtherMessage)
      end
    end
  end
end

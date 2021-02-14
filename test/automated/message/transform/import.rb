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
        context "Message's metadata attributes are equal to the message data's metadata attributes" do
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
        end

        context "Message's metadata properties are equal to the message data's metadata properties" do
          properties = message.metadata.properties
          detail "Message Properties: #{properties.pretty_inspect}"

          message_data_properties = message_data.metadata[:properties]
          detail "MessageData Properties: #{message_data_properties.pretty_inspect}"

          context "Non-Local" do
            source_property_data = message_data_properties[:some_property]

            source_property_value = source_property_data[:value]

            property = properties[:some_property]

            context "Property Value" do
              property_value = property.value

              test do
                assert(property_value == source_property_value)
              end
            end

            context "Locality" do
              test "Is not local" do
                refute(property.local?)
              end
            end
          end

          context "Local" do
            source_property_data = message_data_properties[:some_local_property]

            source_property_value = source_property_data[:value]

            property = properties[:some_local_property]

            context "Property Value" do
              property_value = property.value

              test do
                assert(property_value == source_property_value)
              end
            end

            context "Locality" do
              test "Is local" do
                assert(property.local?)
              end
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

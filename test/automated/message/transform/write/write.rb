require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Write" do
      context "Data" do
        message = Controls::Message.example

        message_data = Transform::Write.(message, :message_data)

        detail "MessageData: #{message_data.pretty_inspect}"
        detail "Message: #{message.pretty_inspect}"

        refute(message_data.id.nil?)
        refute(message_data.type.nil?)
        refute(message_data.data.nil?)
        refute(message_data.data.empty?)
        refute(message_data.metadata[:causation_message_stream_name].nil?)
        refute(message_data.metadata[:causation_message_position].nil?)
        refute(message_data.metadata[:causation_message_global_position].nil?)
        refute(message_data.metadata[:correlation_stream_name].nil?)
        refute(message_data.metadata[:reply_stream_name].nil?)
        refute(message_data.metadata[:properties].nil?)
        refute(message_data.metadata[:properties].empty?)
        refute(message_data.metadata[:schema_version].nil?)

        message_data_properties = message_data.metadata[:properties]
        refute(message_data_properties[:some_property].nil?)

        message_data_local_properties = message_data.metadata[:local_properties]
        refute(message_data_local_properties[:some_local_property].nil?)

        test "ID" do
          assert(message_data.id == message.id)
        end

        test "Type is the message's message type" do
          assert(message_data.type == 'SomeMessage')
        end

        context "Data" do
          data = Controls::Message.data

          test "Data is the message's data" do
            assert(message_data.data == data)
          end

          context "Transient Attributes" do
            message.class.transient_attributes.each do |transient_attribute|
              test "#{transient_attribute} is omitted from the data" do
                assert(data[transient_attribute].nil?)
              end
            end
          end
        end

        context "Metadata" do
          metadata = message_data.metadata

          test "causation_message_stream_name" do
            assert(metadata[:causation_message_stream_name] == message.metadata.causation_message_stream_name)
          end

          test "causation_message_position" do
            assert(metadata[:causation_message_position] == message.metadata.causation_message_position)
          end

          test "causation_message_global_position" do
            assert(metadata[:causation_message_global_position] == message.metadata.causation_message_global_position)
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

          context "properties" do
            properties = metadata[:properties]
            control_properties = {
              some_property: 'some property value'
            }

            detail "Properties: #{properties}"
            detail "Control Properties: #{control_properties}"

            assert(properties == control_properties)
          end

          context "local_properties" do
            local_properties = metadata[:local_properties]
            control_local_properties = {
              some_local_property: 'some local property value'
            }

            detail "Local Properties: #{local_properties}"
            detail "Control Local Properties: #{control_local_properties}"

            assert(local_properties == control_local_properties)
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

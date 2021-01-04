require_relative '../../../automated_init'

context "Message" do
  context "Transform" do
    context "Transient Metadata Properties" do
      message = Controls::Message.example

      metadata = message.metadata

      detail "Message Metadata Before Transform: #{metadata.pretty_inspect}"

      metadata.set_property(:some_transient_property, "some transient value", transient: true)

      message_data = Transform::Write.(message, :message_data)

      detail "Message Metadata After Transform: #{metadata.pretty_inspect}"
      detail "Transformed MessageData: #{message_data.pretty_inspect}"

      transient_properties = message_data.metadata[:properties].select { |property| property.transient? }

      detail "Transient Properties After Transform: #{transient_properties.pretty_inspect}"

      context "Not Written" do
        test do
          assert(transient_properties.empty?)
        end
      end
    end
  end
end

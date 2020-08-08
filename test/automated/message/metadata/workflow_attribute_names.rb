require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Workflow Attribute Names" do
      control_workflow_attribute_names = [:causation_message_stream_name, :causation_message_position, :causation_message_global_position, :reply_stream_name]
      workflow_attribute_names = Message::Metadata.workflow_attributes

      test do
        assert(workflow_attribute_names == workflow_attribute_names)
      end
    end
  end
end

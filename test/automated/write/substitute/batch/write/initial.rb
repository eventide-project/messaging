require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Batch" do
      context "Initial" do
        stream_name = Controls::StreamName.example(category: 'testWriteBatchTelemetry')

        message_1 = Controls::Message.example(some_attribute: 'value_1')
        message_2 = Controls::Message.example(some_attribute: 'value_2')

        batch = [message_1, message_2]

        writer = Write::Substitute.build

        writer.initial(batch, stream_name)

        test "Expected version is no_stream" do
          assert(writer.writes { |msg, stream, expected_version | expected_version == :no_stream }.length == 2)
        end
      end
    end
  end
end

require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Initial" do
        message = Controls::Message.example
        stream_name = Controls::StreamName.example(category: 'testSubstituteWrite')

        writer = Write::Substitute.build
        writer.initial(message, stream_name)

        test "Expected version is no_stream" do
          assert(writer.written? { |msg, stream, expected_version| expected_version == :no_stream })
        end
      end
    end
  end
end

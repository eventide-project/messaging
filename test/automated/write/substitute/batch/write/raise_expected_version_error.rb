require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Batch" do
      context "Write" do
        context "Raise Expected Version Error" do
          stream_name = Controls::StreamName.example(category: 'testSubstituteWrite')

          message_1 = Controls::Message.example(some_attribute: 'value_1')
          message_2 = Controls::Message.example(some_attribute: 'value_2')

          batch = [message_1, message_2]

          writer = Write::Substitute.build

          writer.raise_expected_version_error!

          test "Expected version is no_stream" do
            assert_raises(MessageStore::ExpectedVersion::Error) do
              writer.(batch, stream_name)
            end
          end
        end
      end
    end
  end
end

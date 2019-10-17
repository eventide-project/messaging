require_relative '../automated_init'

context "Write" do
  context "Single Message" do
    stream_name = Controls::StreamName.example(category: 'testWrongVersion')

    message_1 = Controls::Message.example

    Write.(message_1, stream_name)

    message_2 = Controls::Message.example

    context "Right Version" do
      test "Succeeds" do
        Write.(message_2, stream_name, expected_version: 0)
      end
    end

    context "Wrong Version" do
      test "Fails" do
        assert_raises(MessageStore::ExpectedVersion::Error) do
          Write.(message_2, stream_name, expected_version: 11)
        end
      end
    end
  end
end

require_relative '../automated_init'

context "Stream Name" do
  context "Missing ID" do
    test "Is an error" do
      assert_raises Messaging::StreamName::Error do
        StreamName.stream_name(nil)
      end
    end
  end
end

require_relative '../../automated_init'

context "Stream Name" do
  context "Missing ID" do
    test "Is an error" do
      assert_raises(Messaging::StreamName::Error) do
        StreamName.stream_name(category: 'someCategory')
      end
    end
  end
end

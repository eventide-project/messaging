require_relative '../automated_init'

context "Stream Name" do
  context "Missing ID" do
    test "Is an error" do
      assert proc { StreamName.stream_name(nil) } do
        raises_error? Messaging::StreamName::Error
      end
    end
  end
end

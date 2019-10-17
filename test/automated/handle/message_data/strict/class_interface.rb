require_relative '../../../automated_init'

context "Handle" do
  context "MessageData" do
    context "Strict" do
      context "Class Interface" do
        context "Handler Does Not Implement Handle" do
          message_data = Controls::MessageData::Read.example

          test "Is an error" do
            assert_raises(Handle::Error) do
              Controls::Handler::Anomaly::NoHandle::Example.(message_data, strict: true)
            end
          end
        end
      end
    end
  end
end

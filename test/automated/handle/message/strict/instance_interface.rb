require_relative '../../../automated_init'

context "Handle" do
  context "Message" do
    context "Strict" do
      context "Instance Interface" do
        context "Handler Does Not Implement Handle" do
          message = Controls::Message::New.example

          test "Is an error" do
            assert_raises(Handle::Error) do
              Controls::Handler::Anomaly::NoHandle::Example.new.(message, strict: true)
            end
          end
        end
      end
    end
  end
end

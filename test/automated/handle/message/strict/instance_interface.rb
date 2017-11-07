require_relative '../../../automated_init'

context "Handle" do
  context "Message" do
    context "Strict" do
      context "Instance Interface" do
        context "Handler Does Not Implement Handle" do
          message = Controls::Message::New.example

          test "Is an error" do
            assert proc { Controls::Handler::Anomaly::NoHandle::Example.new.(message, strict: true) } do
              raises_error? Handle::Error
            end
          end
        end
      end
    end
  end
end

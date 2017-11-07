require_relative '../../../automated_init'

context "Handle" do
  context "MessageData" do
    context "Strict" do
      context "Class Interface" do
        context "Handler Does Not Implement Handle" do
          message_data = Controls::MessageData::Read.example(data: 1)

          test "Is an error" do
            assert proc { Controls::Handler::Anomaly::NoHandle::Example.(message_data, strict: true) } do
              raises_error? Handle::Error
            end
          end
        end
      end
    end
  end
end

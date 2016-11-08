require_relative '../../automated_init'

context "Handle" do
  context "EventData" do
    context "Strict" do
      context "Handler Implements Handle" do
        event_data = Controls::EventData::Read.example(data: 1)

        Controls::Handler::EventData::Example.(event_data, strict: true)

        test "Event data is handled" do
          assert(event_data.data == 'some value set by handler')
        end
      end

      context "Handler Does Not Implement Handle" do
        event_data = Controls::EventData::Read.example(data: 1)

        test "Is an error" do
          assert proc { Controls::Handler::NoHandle::Example.(event_data, strict: true) } do
            raises_error? Handle::Error
          end
        end
      end
    end
  end
end

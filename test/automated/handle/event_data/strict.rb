require_relative '../../automated_init'

context "Handle" do
  context "EventData" do
    context "Strict" do
      context "Handler Implements Handle" do
        event_data = EventSource::EventData::Read.new

        Controls::Handler::EventData::Example.(event_data, strict: true)

        test "Event data is handled" do
          assert(event_data.data == 'some value')
        end
      end

      context "Handler Does Not Implement Handle" do
        event_data = EventSource::EventData::Read.new

        unchanged_data = event_data.data

        test "Is an error" do
          assert proc { Controls::Handler::NoHandle::Example.(event_data, strict: true) } do
            raises_error? Handle::Error
          end
        end
      end
    end
  end
end

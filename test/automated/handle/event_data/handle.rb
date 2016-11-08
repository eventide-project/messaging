require_relative '../../automated_init'

context "Handle" do
  context "EventData" do
    context "Handle" do
      context "Handler Implements Handle" do
        event_data = Controls::EventData::Read.example(data: 1)

        Controls::Handler::EventData::Example.(event_data)

        test "Event data is handled" do
          assert(event_data.data == 'some value set by handler')
        end
      end

      context "Handler Does Not Implement Handle" do
        event_data = Controls::EventData::Read.example(data: 1)

        unchanged_data = event_data.data

        Controls::Handler::NoHandle::Example.(event_data)

        test "Event data is not handled" do
          assert(event_data.data == unchanged_data)
        end
      end
    end
  end
end

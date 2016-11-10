require_relative '../../automated_init'

context "Handles" do
  context "EventData" do
    context "Handler Implements Message Handler for EventData's Type" do
      event_data = Controls::EventData::Read.example(type: 'SomeMessage')
      handles = Controls::Handler::Example.handles? event_data

      test "Handles" do
        assert(handles)
      end
    end

    context "Handler Does not Implement Message Handler for EventData's Type" do
      event_data = Controls::EventData::Read.example(type: SecureRandom.hex)
      handles = Controls::Handler::Example.handles? event_data

      test "Does not Handle" do
        refute(handles)
      end
    end
  end
end

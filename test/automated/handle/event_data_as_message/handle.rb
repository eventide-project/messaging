require_relative '../../automated_init'

context "Handle" do
  context "Message" do
    context "Handle" do
      context "Handler Implements Message Handler for EventData's Type" do
        context "Message Handler" do
          event_data = Controls::EventData::Read.example(type: 'SomeMessage')

          message = Controls::Handler::Message::Example.(event_data)

          test "EventData is handled as Message" do
            assert(message.some_attribute == 'some value set by handler')
          end
        end

        context "EventData Handler" do
          event_data = Controls::EventData::Read.example(type: 'SomeMessage')

          unchanged_data = event_data.data

          message = Controls::Handler::MessageAndEventData::Example.(event_data)

          message_data = message.to_h

          test "EventData is not handled as EventData" do
            refute(event_data.data == message_data )
          end
        end
      end

      context "Handler Does not Implement Message Handler for EventData's Type" do
        context "Handler Implements Handle" do
          event_data = Controls::EventData::Read.example(type: 'SomeMessage')

          Controls::Handler::EventData::Example.(event_data)

          test "EventData is handled as EventData" do
            assert(event_data.data == 'some value set by handler')
          end
        end

        context "Handler Does not Implement Handle" do
          event_data = Controls::EventData::Read.example(type: 'SomeMessage')

          unchanged_data = event_data.data

          Controls::Handler::NoHandle::Example.(event_data)

          test "EventData is not handled" do
            assert(event_data.data == unchanged_data)
          end
        end
      end
    end
  end
end

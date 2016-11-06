require_relative '../../automated_init'

context "Write" do
  context "Telemetry" do
    context "Reply" do
      message = EventStore::Messaging::Controls::Message.example
      writer = EventStore::Messaging::Writer.build

      SubstAttr::Substitute.(:writer, writer)

      sink = EventStore::Messaging::Writer.register_telemetry_sink(writer)

      writer.reply message

      test "Records replied telemetry" do
        assert(sink.recorded_replied?)
      end
    end
  end
end

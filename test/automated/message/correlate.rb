require_relative '../automated_init'

context "Message" do
  context "Correlate" do
    correlation_stream_name = Controls::Metadata.correlation_stream_name

    message = Controls::Message::Example.correlate(correlation_stream_name)

    test "New message's correlation stream name is set" do
      assert(message.metadata.correlation_stream_name == correlation_stream_name)
    end
  end
end

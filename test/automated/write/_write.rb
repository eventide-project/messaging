require_relative '../automated_init'

context "Write" do
  stream = Controls::Stream.example
  message = Controls::Message.example

  written_position = Write.(message, stream.name)

  read_message = nil
  EventSource::Postgres::Read.(stream, position: written_position, batch_size: 1) do |event_data|
    read_message = Transform::Read.(event_data, :event_data, message.class)
  end


  test "Got the event that was written" do
    assert(read_message == message)
  end
end

require_relative './client_integration_init'

context "Message Writer" do
  test "Writes a message" do
    message = EventStore::Messaging::Controls::Message.example

    writer = EventStore::Messaging::Writer.build

    stream_name = EventStore::Messaging::Controls::StreamName.get 'testWriter'

    writer.write message, stream_name

    path = "/streams/#{stream_name}"
    get = EventStore::Client::HTTP::Request::Get.build
    body_text, get_response = get.("#{path}/0")

    assert(!body_text.nil?)
  end
end

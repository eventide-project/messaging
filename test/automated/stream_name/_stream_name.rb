require_relative '../../automated_init'

context "Category Stream Name (Mixin)" do
  example = EventStore::Messaging::Controls::StreamName.example

  test "Composes the category stream name from the declared category name" do
    category_stream_name = example.category_stream_name
    assert(category_stream_name == '$ce-someCategory')
  end

  test "Composes the category command stream name from the declared category name" do
    command_category_stream_name = example.command_category_stream_name
    assert(command_category_stream_name == '$ce-someCategory:command')
  end
end

context "Category Stream Name (Module Function)" do
  test "Composes the category stream name from the declared category name" do
    category_stream_name = EventStore::Messaging::StreamName.category_stream_name('someCategory')
    assert(category_stream_name == '$ce-someCategory')
  end

  test "Composes the category command stream name from the declared category name" do
    command_category_stream_name = EventStore::Messaging::StreamName.command_category_stream_name('someCategory')
    assert(command_category_stream_name == '$ce-someCategory:command')
  end
end

context "Stream ID" do
  test "Can be derived from the stream name" do
    id = Identifier::UUID.random
    stream_name = "someStream-#{id}"

    stream_id = EventStore::Messaging::StreamName.get_id stream_name
    assert(stream_id == id)
  end

  test "Is nil if there is no type 4 UUID in the stream name" do
    stream_id = EventStore::Messaging::StreamName.get_id 'someStream'
    assert(stream_id.nil?)
  end
end

context "Stream Category" do
  test "Can be derived from the stream name" do
    stream_name = "someStream-id"

    stream_category = EventStore::Messaging::StreamName.get_category stream_name
    assert(stream_category == 'someStream')
  end
end

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

require_relative '../automated_init'

context "Stream Name" do
  example = Messaging::Controls::StreamName::Named.example

  context "Category" do
    test "Camel-cased name specified by the category macro" do
      assert(example.category == 'someCategory')
    end
  end

  context "Identified Stream Name" do
    stream_name = example.stream_name('some_id')
    test "Composed of the category name and an ID" do
      assert(stream_name == 'someCategory-some_id')
    end
  end

  context "Command Stream Name" do
    command_stream_name = example.command_stream_name('some_id')
    test "Composed of the command stream type token, category name, and an ID" do
      assert(command_stream_name == 'someCategory:command-some_id')
    end
  end
end

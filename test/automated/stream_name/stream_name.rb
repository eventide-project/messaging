require_relative '../automated_init'

context "Stream Name" do
  context "Category Stream Name" do
    category_stream_name = StreamName.category_stream_name('someCategory')

    test "Is the category" do
      assert(category_stream_name == 'someCategory')
    end
  end

  context "Identified Stream Name" do
    stream_name = StreamName.stream_name('some_id', 'someCategory')

    test "Composed of the category name and an ID" do
      assert(stream_name == 'someCategory-some_id')
    end
  end

  context "Command Stream Name" do
    command_stream_name = StreamName.command_stream_name('some_id', 'someCategory')

    test "Composed of the command stream type token, category name, and an ID" do
      assert(command_stream_name == 'someCategory:command-some_id')
    end
  end

  context "Command Category Stream Name" do
    command_category_stream_name = StreamName.command_category_stream_name('someCategory')

pp command_category_stream_name

    test "Composed of the command stream type token and the category name" do
      assert(command_category_stream_name == 'someCategory:command')
    end
  end
end

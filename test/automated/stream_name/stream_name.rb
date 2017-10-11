require_relative '../automated_init'

context "Stream Name" do
  context "Stream Name" do
    stream_name = StreamName.stream_name('some_id', 'someCategory')

    test "Composed of the category name and an ID" do
      assert(stream_name == 'someCategory-some_id')
    end
  end

  context "Category Stream Name" do
    category_stream_name = StreamName.category_stream_name('someCategory')

    test "Is the category" do
      assert(category_stream_name == 'someCategory')
    end
  end

  context "Command Stream Name" do
    command_stream_name = StreamName.command_stream_name('some_id', 'someCategory')

    test "Composed of the category name, the command stream type token, and the ID" do
      assert(command_stream_name == 'someCategory:command-some_id')
    end
  end

  context "Command Category Stream Name" do
    command_category_stream_name = StreamName.command_category_stream_name('someCategory')

    test "Composed of the category name and the command stream type token" do
      assert(command_category_stream_name == 'someCategory:command')
    end
  end

  context "Exclusive Command Stream Name" do
    exclusive_command_stream_name = StreamName.exclusive_command_stream_name('some_id', 'someCategory')

    test "Composed of the category name, the command stream type token, the exclusive type token, and the ID" do
      assert(exclusive_command_stream_name == 'someCategory:command+exclusive-some_id')
    end
  end

  context "Exclusive Command Category Stream Name" do
    exclusive_command_category_stream_name = StreamName.exclusive_command_category_stream_name('someCategory')

    test "Composed of the category name, the command stream type token, and the exclusive type token" do
      assert(exclusive_command_category_stream_name == 'someCategory:command+exclusive')
    end
  end
end

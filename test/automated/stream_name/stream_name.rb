require_relative '../automated_init'

context "Stream Name" do
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
end

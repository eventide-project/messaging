__END__

require_relative '../automated_init'

context "Stream Name" do
  context "Category Stream Name" do
    category_stream_name = StreamName.category_stream_name('someCategory')

    test "Is the category" do
      assert(category_stream_name == 'someCategory')
    end
  end

  context "Command Category Stream Name" do
    command_category_stream_name = StreamName.command_category_stream_name('someCategory')

    test "Composed of the category name and the command stream type token" do
      assert(command_category_stream_name == 'someCategory:command')
    end
  end
end

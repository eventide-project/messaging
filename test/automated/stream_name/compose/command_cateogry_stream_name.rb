require_relative '../../automated_init'

context "Stream Name" do
  context "Command Category Stream Name" do
    context do
      command_category_stream_name = StreamName.command_category_stream_name('someCategory')

      test "Composed of the category name and the command stream type token" do
        assert(command_category_stream_name == 'someCategory:command')
      end
    end

    context "With Type" do
      command_category_stream_name = StreamName.command_category_stream_name('someCategory', type: 'some_type')

      test "Composed of the category name, the command type and the provided type" do
        assert(command_category_stream_name == 'someCategory:command+some_type')
      end
    end

    context "With Types" do
      command_category_stream_name = StreamName.command_category_stream_name('someCategory', type: ['some_type', 'some_other_type'])

      test "Composed of the category name, the command type and the provided types" do
        assert(command_category_stream_name == 'someCategory:command+some_type+some_other_type')
      end
    end
  end
end

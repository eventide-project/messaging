require_relative '../../automated_init'

context "Stream Name" do
  context "Command Stream Name" do
    context do
      command_stream_name = StreamName.command_stream_name('some_id', 'someCategory')

      test "Composed of the category name, the command stream type token, and the ID" do
        assert(command_stream_name == 'someCategory:command-some_id')
      end
    end

    context "With Type" do
      command_stream_name = StreamName.command_stream_name('some_id', 'someCategory', type: 'some_type')

      test "Composed of the category name, the command type and the provided type, and the ID" do
        assert(command_stream_name == 'someCategory:command+some_type-some_id')
      end
    end

    context "With Types" do
      command_stream_name = StreamName.command_stream_name('some_id', 'someCategory', types: ['some_type', 'some_other_type'])

      test "Composed of the category name, the command type and the provided types, and the ID" do
        assert(command_stream_name == 'someCategory:command+some_type+some_other_type-some_id')
      end
    end
  end
end

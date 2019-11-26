require_relative '../../automated_init'

context "Stream Name" do
  example = Controls::StreamName::NamedCategory.example

  context "Category Macro" do
    context "Specify Category" do
      test "Camel-cased name specified by the category macro" do
        assert(example.category == 'someCategory')
      end
    end

    context "Overridden" do
      category = 'otherCategory'

      overridden_example = Controls::StreamName::NamedCategory.example

      overridden_example.category = category

      test do
        assert(overridden_example.category == category)
      end
    end
  end

  context "Stream Name" do
    stream_name = example.stream_name('some_id')

    test "Composed of the category name and the ID" do
      assert(stream_name == 'someCategory-some_id')
    end
  end

  context "Category Stream Name" do
    category_stream_name = example.category_stream_name

    test "Is the category name" do
      assert(category_stream_name == example.category)
    end
  end

  context "Command Stream Name" do
    command_stream_name = example.command_stream_name('some_id')

    test "Composed of the category name, the command stream type token, and the ID" do
      assert(command_stream_name == 'someCategory:command-some_id')
    end
  end

  context "Command Category Stream Name" do
    command_category_stream_name = example.command_category_stream_name

    test "Composed of the category name and the command stream type token" do
      assert(command_category_stream_name == 'someCategory:command')
    end
  end
end

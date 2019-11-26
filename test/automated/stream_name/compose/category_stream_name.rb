require_relative '../../automated_init'

context "Stream Name" do
  context "Category Stream Name" do
    context do
      category_stream_name = StreamName.category_stream_name('someCategory')

      test "Is the category" do
        assert(category_stream_name == 'someCategory')
      end
    end

    context "With Type" do
      category_stream_name = StreamName.category_stream_name('someCategory', type: 'some_type')

      test "Composed of the category name and type" do
        assert(category_stream_name == 'someCategory:some_type')
      end
    end

    context "With Types" do
      category_stream_name = StreamName.category_stream_name('someCategory', types: ['some_type', 'some_other_type'])

      test "Composed of the category name and type" do
        assert(category_stream_name == 'someCategory:some_type+some_other_type')
      end
    end
  end
end

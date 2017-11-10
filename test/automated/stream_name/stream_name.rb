require_relative '../automated_init'

context "Stream Name" do
  context do
    stream_name = StreamName.stream_name('some_id', 'someCategory')

    test "Composed of the category name and an ID" do
      assert(stream_name == 'someCategory-some_id')
    end
  end

  context "With Type" do
    stream_name = StreamName.stream_name('some_id', 'someCategory', type: 'some_type')

    test "Composed of the category name, type, and an ID" do
      assert(stream_name == 'someCategory:some_type-some_id')
    end
  end

  context "With Types" do
    stream_name = StreamName.stream_name('some_id', 'someCategory', types: ['some_type', 'some_other_type'])

    test "Composed of the category name, types, and an ID" do
      assert(stream_name == 'someCategory:some_type+some_other_type-some_id')
    end
  end
end

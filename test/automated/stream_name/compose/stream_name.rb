require_relative '../../automated_init'

context "Stream Name" do
  context "Positional ID and Positional Category" do
    stream_name = StreamName.stream_name('some_positional_id', 'someCategory')

    test "Composed of category and ID" do
      assert(stream_name == 'someCategory-some_positional_id')
    end
  end

  context "Cardinal ID and Named Category" do
    stream_name = StreamName.stream_name(category: 'someCategory', cardinal_id: 'some_cardinal_id')

    test "Composed of named category and cardinal ID" do
      assert(stream_name == 'someCategory-some_cardinal_id')
    end
  end

  context "ID, Positional Category, and Named Category" do
    stream_name = StreamName.stream_name('some_positional_id', 'somePositionalCategory', category: 'someNamedCategory')

    test "Positional category takes precedence" do
      assert(stream_name == 'somePositionalCategory-some_positional_id')
    end
  end

  context "All ID Options" do
    stream_name = StreamName.stream_name(['some_positional_id', 'some_other_positional_id'], 'someCategory', cardinal_id: 'some_cardinal_id', id: 'some_named_id', ids: ['some_other_named_id', 'yet_another_named_id'])

    test "Composed of category, cardinal ID, and positional ID, named ID, and named IDs" do
      assert(stream_name == 'someCategory-some_cardinal_id+some_positional_id+some_other_positional_id+some_named_id+some_other_named_id+yet_another_named_id')
    end
  end

  context "With Type" do
    stream_name = StreamName.stream_name('some_positional_id', 'someCategory', type: 'some_type')

    test "Composed of the category name, type, and ID" do
      assert(stream_name == 'someCategory:some_type-some_positional_id')
    end
  end

  context "With Types" do
    stream_name = StreamName.stream_name('some_positional_id', 'someCategory', types: ['some_type', 'some_other_type'])

    test "Composed of the category name, types, and ID" do
      assert(stream_name == 'someCategory:some_type+some_other_type-some_positional_id')
    end
  end
end

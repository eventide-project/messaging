require_relative '../automated_init'

context "Get Category" do
  category = 'someStream'

  test "Is the part of a stream name before the first dash" do
    id = Identifier::UUID.random
    stream_name = "#{category}-#{id}"

    stream_category = StreamName.get_category(stream_name)

    assert(stream_category == category)
  end

  test "Is the category name if there is no ID part in the stream name" do
    stream_category = StreamName.get_category(category)
    assert(stream_category == category)
  end
end

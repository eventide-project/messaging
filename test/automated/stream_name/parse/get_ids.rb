require_relative '../../automated_init'

context "Stream Name" do
  context "Get IDs" do
    context "Compound ID in the Stream Name" do
      stream_name = 'someCategory-some_id+some_other_id'

      stream_ids = StreamName.get_ids(stream_name)

      test "ID is a list of values" do
        assert(stream_ids == ['some_id', 'some_other_id'])
      end
    end

    context "Single ID in the Stream Name" do
      stream_name = "someCategory-some_id"

      stream_ids = StreamName.get_ids(stream_name)

      test "ID list has a single entry" do
        assert(stream_ids == ['some_id'])
      end
    end

    context "No ID in the Stream Name" do
      stream_ids = StreamName.get_ids('someStream')

      test "ID is an empty list" do
        assert(stream_ids == [])
      end
    end
  end
end

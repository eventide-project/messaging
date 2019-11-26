require_relative '../../automated_init'

context "Stream Name" do
  context "Get Cardinal ID" do
    context "Compound ID in the Stream Name" do
      stream_name = 'someCategory-some_id+some_other_id'

      cardinal_id = StreamName.get_cardinal_id(stream_name)

      test "Cardinal ID is parsed" do
        assert(cardinal_id == 'some_id')
      end
    end

    context "Single ID in the Stream Name" do
      stream_name = 'someCategory-some_id'

      cardinal_id = StreamName.get_cardinal_id(stream_name)

      test "ID is parsed" do
        assert(cardinal_id == 'some_id')
      end
    end

    context "No ID in the Stream Name" do
      stream_name = 'someCategory'

      cardinal_id = StreamName.get_cardinal_id(stream_name)

      test "ID is nil" do
        assert(cardinal_id.nil?)
      end
    end
  end
end

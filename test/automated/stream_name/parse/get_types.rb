require_relative '../../automated_init'

context "Stream Name" do
  context "Get Types" do
    context "Single Type in the Stream Name" do
      stream_name = 'someCategory:someType'

      types = StreamName.get_types(stream_name)

      test "Type is parsed" do
        assert(types == ['someType'])
      end
    end

    context "Compound Type in the Stream Name" do
      stream_name = 'someCategory:someType+someOtherType'

      types = StreamName.get_types(stream_name)

      test "Type is parsed" do
        assert(types == ['someType', 'someOtherType'])
      end
    end

    context "No Type in the Stream Name" do
      stream_name = 'someCategory'

      types = StreamName.get_types(stream_name)

      test "Type is nil" do
        assert(types == [])
      end
    end
  end
end

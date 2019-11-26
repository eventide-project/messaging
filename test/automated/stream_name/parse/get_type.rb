require_relative '../../automated_init'

context "Stream Name" do
  context "Get Type" do
    context "Type in the Stream Name" do
      stream_name = 'someCategory:someType'

      type = StreamName.get_type(stream_name)

      test "Type is parsed" do
        assert(type == 'someType')
      end
    end

    context "Compound Type in the Stream Name" do
      stream_name = 'someCategory:someType+someOtherType'

      type = StreamName.get_type(stream_name)

      test "Type is parsed" do
        assert(type == 'someType+someOtherType')
      end
    end

    context "No Type in the Stream Name" do
      stream_name = 'someCategory'

      type = StreamName.get_type(stream_name)

      test "Type is nil" do
        assert(type.nil?)
      end
    end
  end
end

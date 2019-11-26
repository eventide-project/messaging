require_relative '../../automated_init'

context "Stream Name" do
  context "Get Entity Name" do
    context "Stream Name Does Not Contain an ID" do
      stream_name = 'someStream'

      enity_name = StreamName.get_entity_name(stream_name)

      test "Entity name is parsed" do
        assert(enity_name == 'someStream')
      end
    end

    context "Stream Name Contains an ID" do
      stream_name = 'someStream-some_id'

      enity_name = StreamName.get_entity_name(stream_name)

      test "Entity name is parsed" do
        assert(enity_name == 'someStream')
      end
    end

    context "Stream Name Contains Type" do
      stream_name = 'someStream:someType'

      enity_name = StreamName.get_entity_name(stream_name)

      test "Entity name is parsed" do
        assert(enity_name == 'someStream')
      end
    end

    context "Stream Name Contains Types" do
      stream_name = 'someStream:someType+someOtherType'

      enity_name = StreamName.get_entity_name(stream_name)

      test "Entity name is parsed" do
        assert(enity_name == 'someStream')
      end
    end

    context "Stream Name Contains ID and Types" do
      stream_name = 'someStream:someType+someOtherType-some_id'

      enity_name = StreamName.get_entity_name(stream_name)

      test "Entity name is parsed" do
        assert(enity_name == 'someStream')
      end
    end
  end
end

require_relative '../automated_init'

context "Message" do
  context "Read" do
    attribute_value = SecureRandom.hex

    context "Message Has Read Template Method" do
      message = Controls::Message::Read.build(some_attribute: attribute_value)

      control_imported_value = "#{attribute_value} read"

      imported_value = message.some_attribute

      test "Attribute is intercepted and modified" do
        assert(imported_value == control_imported_value)
      end
    end

    context "Message Does Not Have Read Template Method" do
      message = Controls::Message::SingleAttribute.build(some_attribute: attribute_value)

      control_imported_value = "#{attribute_value} read"

      imported_value = message.some_attribute

      test "Attribute is not intercepted and modified" do
        refute(imported_value == control_imported_value)
      end
    end
  end
end

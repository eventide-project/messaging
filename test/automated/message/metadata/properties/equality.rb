require_relative '../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Properties" do
      context "Equality" do
        context "Equal" do
          context "Same Attribute Values" do
            property_1 = Message::Metadata::Property.new('some value', true)
            property_2 = Message::Metadata::Property.new('some value', true)

            test do
              assert(property_1 == property_2)
            end
          end

          context "Equivalent Transience" do
            property_1 = Message::Metadata::Property.new('some value', nil)
            property_2 = Message::Metadata::Property.new('some value', false)

            test do
              assert(property_1 == property_2)
            end
          end
        end

        context "Not Equal" do
          context "Different Values" do
            property_1 = Message::Metadata::Property.new('some value', true)
            property_2 = Message::Metadata::Property.new('some other value', true)

            test do
              refute(property_1 == property_2)
            end
          end

          context "Different Transience" do
            property_1 = Message::Metadata::Property.new('some value', true)
            property_2 = Message::Metadata::Property.new('some value', false)

            test do
              refute(property_1 == property_2)
            end
          end
        end
      end
    end
  end
end

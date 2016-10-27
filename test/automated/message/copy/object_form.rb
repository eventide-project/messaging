require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Object Form" do
      source = Controls::Message.example

      context "Default" do
        receiver = source.class.new

        Message::Copy.(source, receiver)

        test "All attributes are copied" do
          assert(source == receiver)
        end
      end

      context "Include attributes" do
        context "All attributes" do
          receiver = source.class.new

          Message::Copy.(source, receiver, include: [
            :some_attribute,
            :other_attribute
          ])

          test "All attributes are copied" do
            assert(source == receiver)
          end
        end

        context "Some attributes" do
          receiver = source.class.new

          Message::Copy.(source, receiver, include: [
            :some_attribute
          ])

          test "Specified attributes are copied" do
            assert(source.some_attribute == receiver.some_attribute)
          end

          test "Other attributes are not copied" do
            refute(source.other_attribute == receiver.other_attribute)
          end
        end
      end

      context "Exclude Attributes" do
        context "All attributes" do
          receiver = source.class.new

          Message::Copy.(source, receiver, exclude: [
            :some_attribute,
            :other_attribute
          ])

          test "No attributes are copied" do
            assert(receiver.some_attribute.nil?)
            assert(receiver.other_attribute.nil?)
          end
        end

        context "Some Attributes" do
          receiver = source.class.new

          Message::Copy.(source, receiver, exclude: [
            :some_attribute
          ])

          test "Specified attributes are excluded" do
            assert(receiver.some_attribute.nil?)
          end

          test "Other attributes are copied" do
            assert(source.other_attribute == receiver.other_attribute)
          end
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Class Form" do
      source = Controls::Message.example

      context "Default" do
        receiver = Messaging::Message::Copy.(source, source.class)

        test "Constructs the class" do
          assert(receiver.class == source.class)
        end

        test "All attributes are copied" do
          assert(source == receiver)
        end
      end

      context "Include attributes" do
        context "All attributes" do
          receiver = Messaging::Message::Copy.(source, source.class, include: [
            :some_attribute,
            :other_attribute
          ])

          test "Constructs the class" do
            assert(receiver.class == source.class)
          end

          test "All attributes are copied" do
            assert(source == receiver)
          end
        end

        context "Some attributes" do
          receiver = Messaging::Message::Copy.(source, source.class, include: [
            :some_attribute
          ])

          test "Constructs the class" do
            assert(receiver.class == source.class)
          end

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
          receiver = Messaging::Message::Copy.(source, source.class, exclude: [
            :some_attribute,
            :other_attribute
          ])

          test "Constructs the class" do
            assert(receiver.class == source.class)
          end

          test "No attributes are copied" do
            assert(receiver.some_attribute.nil?)
            assert(receiver.other_attribute.nil?)
          end
        end

        context "Some Attributes" do
          receiver = Messaging::Message::Copy.(source, source.class, exclude: [
            :some_attribute
          ])

          test "Constructs the class" do
            assert(receiver.class == source.class)
          end

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

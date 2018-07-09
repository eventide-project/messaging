require_relative '../../automated_init'

context "Message" do
  context "Copy" do
    context "Object Form" do
      source = Controls::Message.example

      context "Source and Receiver Have Same Attributes" do
        receiver = source.class.new

        Message::Copy.(source, receiver)

        test "All attributes are copied" do
          assert(receiver == source)
        end

        test "Metadata is not copied" do
          refute(receiver.metadata == source.metadata)
        end
      end

      context "Attribute Mapping" do
        receiver = Controls::Message::OtherMessage.new

        Messaging::Message::Copy.(source, receiver, include: [
          { :some_attribute => :an_attribute },
          :other_attribute
        ])

        test "Mapped attributes are copied" do
          assert(receiver.an_attribute == source.some_attribute)
        end

        test "Other attributes are copied" do
          assert(receiver.other_attribute == source.other_attribute)
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
            assert(receiver == source)
          end
        end

        context "Some attributes" do
          receiver = source.class.new

          Message::Copy.(source, receiver, include: [
            :some_attribute
          ])

          test "Specified attributes are copied" do
            assert(receiver.some_attribute == source.some_attribute)
          end

          test "Other attributes are not copied" do
            refute(receiver.other_attribute == source.other_attribute)
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
            assert(receiver.other_attribute == source.other_attribute)
          end
        end
      end
    end
  end
end

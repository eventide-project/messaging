require_relative '../automated_init'

context "Message" do
  context "Info" do
    context "Class" do
      message_class = Controls::Message.message_class

      context "Message Type" do
        type = message_class.message_type

        test "Inner-most namespace of message's class name" do
          assert(type == "SomeMessage")
        end
      end

      context "Message Type Predicate" do
        context "Affirmative" do
          type = message_class.message_type

          test "Message's type is equal to the compare value" do
            assert(message_class.message_type?(type))
          end
        end

        context "Negative" do
          test "Message's type is not equal to the compare value" do
            refute(message_class.message_type?(SecureRandom.hex))
          end
        end
      end

      context "Message Name" do
        name = message_class.message_name

        test "Underscore case of the message's name" do
          assert(name == "some_message")
        end
      end
    end

    context "Instance" do
      message = Controls::Message.example

      context "Message Type" do
        type = message.message_type

        test "Inner-most namespace of message's class name" do
          assert(type == "SomeMessage")
        end
      end

      context "Message Name" do
        name = message.message_name

        test "Underscore case of the message's name" do
          assert(name == "some_message")
        end
      end
    end
  end
end

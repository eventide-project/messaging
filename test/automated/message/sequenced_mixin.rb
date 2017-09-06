require_relative '../automated_init'

context "Message" do
  context "Sequenced Mixin" do
    message = Controls::Message::Sequenced.example

    refute(message.metadata.causation_message_global_position.nil?)

    test "Message is a Messaging::Message" do
      assert(message.is_a?(Messaging::Message))
    end

    test "Message is a Messaging::SequenceAttribute" do
      assert(message.is_a?(Messaging::Message))
    end

    test "Adds a 'sequence' attribute" do
      assert(message.respond_to?(:sequence))
    end

    context "Sequence Attribute" do
      sequence = Controls::Random::Number.example
      message.sequence = sequence

      context "Writer" do
        test "Delegates to the causation_message_global_position attribute writer" do
          assert(message.metadata.causation_message_global_position == sequence)
        end
      end

      context "Reader" do
        read_sequence = message.sequence

        test "Delegates to the causation_message_global_position attribute writer" do
          assert(message.metadata.causation_message_global_position == read_sequence)
        end
      end
    end
  end
end

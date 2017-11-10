require_relative '../../automated_init'

context "Message" do
  context "Event" do
    context "Sequence Accessor" do
      message = Controls::Message.example

      refute(message.metadata.causation_message_global_position.nil?)
      refute(message.respond_to?(:sequence))

      message.extend Message::Event::SequenceAccessor

      test "Adds a 'sequence' attribute" do
        assert(message.respond_to? :sequence)
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

          test "Delegates to the causation_message_global_position attribute reader" do
            assert(read_sequence == message.metadata.causation_message_global_position)
          end
        end
      end
    end
  end
end

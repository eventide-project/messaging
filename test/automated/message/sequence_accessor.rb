require_relative '../automated_init'

context "Message" do
  context "Sequence Accessor" do
    message = Controls::Message.example

    refute(message.metadata.global_position.nil?)
    refute(message.respond_to?(:sequence))

    message.extend Message::SequenceAccessor

    test "Adds a 'sequence' attribute" do
      assert(message.respond_to? :sequence)
    end

    context "Sequence Attribute" do
      context "Reader" do
        sequence = message.sequence

        test "Delegates to the global_position attribute reader" do
          assert(sequence == message.metadata.global_position)
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Write" do
  context "Message" do
    context "No ID" do
      stream_name = Controls::StreamName.example

      message = Controls::Message.example(id: :none)

      assert(message.id.nil?)

      position = Write.(message, stream_name)

      read_message = MessageStore::Get.(stream_name, position: position, batch_size: 1).first

      test "Assigns an ID" do
        refute(read_message.id.nil?)
      end
    end
  end
end

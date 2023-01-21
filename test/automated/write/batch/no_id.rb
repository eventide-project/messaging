require_relative '../../automated_init'

context "Write" do
  context "Batch" do
    context "No Message IDs" do
      stream_name = Controls::StreamName.example

      batch, values = Controls::Batch.example(id: :none)

      batch.each do |message|
        assert(message.id.nil?)
      end

      position = Write.(batch, stream_name)

      context "Individual Events are Written" do
        2.times do |i|
          read_message = MessageStore::Get.(stream_name, position: i, batch_size: 1).first

          context "Assigns an ID" do
            test "Event #{i + 1}" do
              refute(read_message.id.nil?)
            end
          end
        end
      end
    end
  end
end

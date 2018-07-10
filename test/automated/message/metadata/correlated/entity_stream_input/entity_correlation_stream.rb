require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Correlated" do
      context "Entity Stream Input" do
        context "Entity Correlation Stream Name" do
          metadata = Controls::Metadata.example

          metadata.correlation_stream_name = 'someStream-123'

          context "Correlation Stream Name Is the Stream Name" do
            test "Is correlated" do
              assert(metadata.correlated?('someStream-123'))
            end
          end

          context "Correlation Stream Name Is Not the Stream Name" do
            test "Is not correlated" do
              refute(metadata.correlated?("a#{SecureRandom.hex}-123"))
            end
          end
        end
      end
    end
  end
end

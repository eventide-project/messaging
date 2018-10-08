require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Correlated" do
      context "Category Input" do
        context "No Correlation Stream Name" do
          metadata = Controls::Metadata.example

          metadata.correlation_stream_name = nil

          test "Is not correlated" do
            refute(metadata.correlated?('someStream'))
          end
        end
      end
    end
  end
end

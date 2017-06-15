require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Correlated" do
      context "Category Input" do
        context "Entity Correlation Stream Name" do
          metadata = Controls::Metadata.example

          metadata.correlation_stream_name = 'someStream-123'

          context "String Form" do
            context "Correlation Stream Name Includes the Stream Name" do
              test "Is correlated" do
                assert(metadata.correlated?('someStream'))
              end
            end

            context "Correlation Stream Name Does Not Include the Stream Name" do
              test "Is not correlated" do
                refute(metadata.correlated?(SecureRandom.hex))
              end
            end
          end

          context "Symbol Form" do
            context "Correlation Stream Name Includes the Stream Name" do
              test "Is correlated" do
                assert(metadata.correlated?(:some_stream))
              end
            end

            context "Correlation Stream Name Does Not Include the Stream Name" do
              test "Is not correlated" do
                refute(metadata.correlated?(:"a#{SecureRandom.hex}"))
              end
            end
          end
        end
      end
    end
  end
end

require_relative '../../../../automated_init'

context "Message" do
  context "Metadata" do
    context "Correlated" do
      context "Category Input" do
        context "Category Correlation Stream Name" do
          metadata = Controls::Metadata.example

          metadata.correlation_stream_name = 'someStream'

          context "String Form" do
            context "Correlation Stream Name Is the Category" do
              test "Is correlated" do
                assert(metadata.correlated?('someStream'))
              end
            end

            context "Correlation Stream Name Is Not the Category" do
              test "Is not correlated" do
                refute(metadata.correlated?(SecureRandom.hex))
              end
            end
          end

          context "Symbol Form" do
            context "Correlation Stream Name Is the Category" do
              test "Is correlated" do
                assert(metadata.correlated?(:some_stream))
              end
            end

            context "Correlation Stream Name Is Not the Category" do
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

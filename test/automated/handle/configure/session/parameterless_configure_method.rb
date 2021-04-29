require_relative '../../../automated_init'

context "Handle" do
  context "Configure" do
    context "Session" do
      context "Parameterless Configure Method" do
        handler_class = Controls::Handler::Example

        context "Given" do
          session = Object.new

          test "Argument error not raised" do
            refute_raises(ArgumentError) do
              handler_class.build(session: session)
            end
          end
        end

        context "Not Given" do
          test "Argument error not raised" do
            refute_raises(ArgumentError) do
              handler_class.build
            end
          end
        end
      end
    end
  end
end

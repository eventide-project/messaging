require_relative '../../../automated_init'

context "Handle" do
  context "Configure" do
    context "Settings" do
      context "Parameterless Configure Method" do
        handler_class = Controls::Handler::Example

        context "Given" do
          settings = Object.new

          test "Argument error not raised" do
            refute_raises(ArgumentError) do
              handler_class.build(settings: settings)
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

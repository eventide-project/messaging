require_relative '../../automated_init'

context "Handle" do
  context "Session Configuration" do
    context "Bare Configure Method" do
      handler_class = Controls::Handler::Example

      context "Given" do
        session = Object.new

        test "Argument error not raised" do
          refute proc { handler_class.build(session: session) } do
            raises_error?(ArgumentError)
          end
        end
      end

      context "Not Given" do
        test "Argument error not raised" do
          refute proc { handler_class.build } do
            raises_error?(ArgumentError)
          end
        end
      end
    end
  end
end

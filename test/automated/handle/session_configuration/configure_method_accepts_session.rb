require_relative '../../automated_init'

context "Handle" do
  context "Session Configuration" do
    context "Configure Method Accepts Session Argument" do
      handler_class = Controls::Handler::SessionArgument::Example

      context "Given" do
        session = Object.new

        handler = handler_class.build(session: session)

        test "Session is passed to configure method" do
          assert(handler.session.equal?(session))
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

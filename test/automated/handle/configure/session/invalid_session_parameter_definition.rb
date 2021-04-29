require_relative '../../../automated_init'

context "Handle" do
  context "Configure" do
    context "Session" do
      context "Invalid Session Parameter Definition" do
        context "Session is a Positional Argument" do
          handler_class = Class.new do
            include Messaging::Handle

            def configure(session)
            end
          end

          test "Is an error" do
            assert_raises(Messaging::Handle::Build::Error) do
              handler_class.build
            end
          end
        end

        context "Session Is an Optional Positional Argument" do
          handler_class = Class.new do
            include Messaging::Handle

            def configure(session=nil)
            end
          end

          test "Is an error" do
            assert_raises(Messaging::Handle::Build::Error) do
              handler_class.build
            end
          end
        end
      end
    end
  end
end

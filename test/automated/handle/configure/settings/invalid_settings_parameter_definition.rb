require_relative '../../../automated_init'

context "Handle" do
  context "Configure" do
    context "Settings" do
      context "Invalid Settings Parameter Definition" do
        context "Settings is a Positional Argument" do
          handler_class = Class.new do
            include Messaging::Handle

            def configure(settings)
            end
          end

          test "Is an error" do
            assert_raises(Messaging::Handle::Build::Error) do
              handler_class.build
            end
          end
        end

        context "Settings Is an Optional Positional Argument" do
          handler_class = Class.new do
            include Messaging::Handle

            def configure(settings=nil)
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

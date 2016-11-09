require_relative '../../automated_init'

context "Handle" do
  context "Macro" do
    context "Handler Block Without Parameter" do
      define_handler = proc do
        Class.new do
          include Messaging::Handle

          handle Controls::Message::SomeMessage do
          end
        end
      end

      test "Is an error" do
        assert define_handler do
          raises_error? Handle::HandleMacro::Error
        end
      end
    end
  end
end

require_relative '../../automated_init'

context "Handle" do
  context "Macro" do
    context "Handler Block Without Parameter" do
      test "Is an error" do
        assert_raises(Handle::HandleMacro::Error) do
          Class.new do
            include Messaging::Handle

            handle Controls::Message::SomeMessage do
            end
          end
        end
      end
    end
  end
end

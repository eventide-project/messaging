require_relative '../../automated_init'

context "Handle" do
  context "Macro" do
    handler = Controls::Handler::Example.new

    test "Defines handler methods" do
      assert(handler.respond_to? :handle_some_message)
    end

    test "Registers message classes" do
      assert(handler.class.message_registry.registered? Controls::Message::SomeMessage)
    end
  end
end

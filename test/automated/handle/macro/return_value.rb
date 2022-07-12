require_relative '../../automated_init'

context "Handle" do
  context "Macro" do
    context "Return Value" do
      return_value = nil
      method_name = :handle_some_message

      Class.new do
        include Messaging::Handle

        return_value = handle Controls::Message::SomeMessage do |message|
        end
      end

      comment return_value.inspect

      test "Is method name" do
        assert(return_value == method_name)
      end
    end
  end
end

require_relative 'automated_init'

context "Message Registry" do
  registry = MessageRegistry.new
  message_class = Controls::Message::SomeMessage

  registry.register(message_class)

  context "Register items" do
    registered = registry.registered?(message_class)

    test "Message is registered" do
      assert(registered)
    end
  end

  context "Registering message classes more than once" do
    test "Is an error" do
      assert_raises(MessageRegistry::Error) do
        registry.register(message_class)
      end
    end
  end

  context "Retrieve message classes by message type" do
    retrieved_message_class = registry.get(message_class.message_name)

    test "Retrieves the message class" do
      assert(retrieved_message_class == message_class)
    end
  end
end

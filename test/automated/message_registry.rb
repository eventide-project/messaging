require_relative 'automated_init'

context "Message Registry" do
  registry = MessageRegistry.new
  message_class = Controls::Message::SomeMessage
  other_message_class = Controls::Message::OtherMessage

  registry.register(message_class)
  registry.register(other_message_class)

  context "Register Items" do
    registered = registry.registered?(message_class)

    test "Message is registered" do
      assert(registered)
    end
  end

  context "Registering Message Classes More than Once" do
    test "Is an error" do
      assert_raises(MessageRegistry::Error) do
        registry.register(message_class)
      end
    end
  end

  context "Retrieve Message Classes by Message Type" do
    retrieved_message_class = registry.get(message_class.message_name)

    test "Retrieves the message class" do
      assert(retrieved_message_class == message_class)
    end
  end

  context "Message Types" do
    message_names = registry.message_types

    control_message_names = ['SomeMessage', 'OtherMessage']

    test "List of message types" do
      assert(message_names == control_message_names)
    end
  end
end

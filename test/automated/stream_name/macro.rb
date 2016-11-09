require_relative '../automated_init'

context "Stream Name" do
  example = Messaging::Controls::StreamName::Named.example

  context "Macro" do
    test "Adds the category_name instance method" do
      assert(example.respond_to? :category)
    end
  end
end

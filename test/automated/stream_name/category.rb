require_relative '../automated_init'

context "Stream Name" do
  example = Messaging::Controls::StreamName::Named.example

  context "Category specified by macro" do
    test do
      assert example.category == 'someCategory'
    end
  end

  context "Category is overridden" do
    category = 'otherCategory'

    example.category = category

    test do
      assert(example.category == category)
    end
  end
end

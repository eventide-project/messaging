require_relative '../../automated_init'

context "Handle" do
  context "Settings" do
    handler = Controls::Handler.example

    test "Handler is a Settings::Setting" do
      assert(handler.is_a?(Settings::Setting))
    end
  end
end

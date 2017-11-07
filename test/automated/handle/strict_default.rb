require_relative '../automated_init'

context "Handle" do
  context "Strict Default" do
    prior_default = Handle::Defaults::Strict.get

    context "Off" do
      Handle::Defaults::Strict::Set.off

      refute(Handle::Defaults.strict)

      handler = Controls::Handler::Example.build

      test "Not strict" do
        refute(handler.strict)
      end
    end

    context "On" do
      Handle::Defaults::Strict::Set.on

      assert(Handle::Defaults.strict)

      handler = Controls::Handler::Example.build

      test "Strict" do
        assert(handler.strict)
      end
    end

    Handle::Defaults::Strict.set(prior_default)
  end
end

require_relative '../automated_init'

context "Handle" do
  context "Build" do
    assert(Controls::Handler::Example.new.session.nil?)

    context "With Session" do
      session = Object.new
      handler = Controls::Handler::Example.build(session: session)

      test "Session is assigned to handler" do
        assert(handler.session == session)
      end
    end

    context "Without Session" do
      handler = Controls::Handler::Example.build

      test "Session is assigned to handler" do
        assert(handler.session.nil?)
      end
    end
  end
end

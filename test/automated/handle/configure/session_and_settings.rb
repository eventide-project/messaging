require_relative '../../automated_init'

context "Handle" do
  context "Configure" do
    context "Session and Settings" do
      handler_class = Class.new do
        include Messaging::Handle

        attr_accessor :session
        attr_accessor :settings

        def configure(session: nil, settings: nil)
          self.session = session
          self.settings = settings
        end
      end

      session = Object.new
      settings = Object.new

      context "Passed to configure method" do
        handler = handler_class.build(session: session, settings: settings)

        test "Session" do
          assert(handler.session.equal?(session))
        end

        test "Settings" do
          assert(handler.settings.equal?(settings))
        end
      end
    end
  end
end

require_relative '../../../automated_init'

context "Handle" do
  context "Configure" do
    context "Session" do
      context "Configure Method Receives Session" do
        context "Session Is an Optional Keyword Argument" do
          handler_class = Class.new do
            include Messaging::Handle

            attr_accessor :session

            def configure(session: nil)
              self.session = session
            end
          end

          context "Given" do
            session = Object.new

            context "Session is passed to configure method" do
              handler = handler_class.build(session: session)

              test do
                assert(handler.session.equal?(session))
              end
            end
          end

          context "Not Given" do
            test "Argument error not raised" do
              refute_raises(ArgumentError) do
                handler_class.build
              end
            end
          end
        end

        context "Session is a required keyword argument" do
          handler_class = Class.new do
            include Messaging::Handle

            attr_accessor :session

            def configure(session:)
              self.session = session
            end
          end

          context "Given" do
            session = Object.new

            context "Session is passed to configure method" do
              handler = handler_class.build(session: session)

              test do
                assert(handler.session.equal?(session))
              end
            end
          end

          context "Not Given" do
            test "Argument error is raised" do
              assert_raises(ArgumentError) do
                handler_class.build
              end
            end
          end
        end
      end
    end
  end
end

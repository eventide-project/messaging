require_relative '../../../automated_init'

context "Handle" do
  context "Configure" do
    context "Settings" do
      context "Configure Method Receives Settings" do
        context "Settings Is an Optional Keyword Argument" do
          handler_class = Class.new do
            include Messaging::Handle

            attr_accessor :settings

            def configure(settings: nil)
              self.settings = settings
            end
          end

          context "Given" do
            settings = Object.new

            context "Settings is passed to configure method" do
              handler = handler_class.build(settings: settings)

              test do
                assert(handler.settings.equal?(settings))
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

        context "Settings is a required keyword argument" do
          handler_class = Class.new do
            include Messaging::Handle

            attr_accessor :settings

            def configure(settings:)
              self.settings = settings
            end
          end

          context "Given" do
            settings = Object.new

            context "Settings is passed to configure method" do
              handler = handler_class.build(settings: settings)

              test do
                assert(handler.settings.equal?(settings))
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

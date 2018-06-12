require_relative '../../automated_init'

context "Handle" do
  context "Session Configuration" do
    context "Configure Method Includes Invalid Session Parameter" do
      context "Session is positional argument" do
        handler_class = Controls::Handler::SessionArgument::Invalid::Positional::Example

        context "Given" do
          session = Object.new

          test "Argument error is raised" do
            assert proc { handler_class.build(session: session) } do
              raises_error?(ArgumentError)
            end
          end
        end

        context "Not Given" do
          test "Argument error is raised" do
            assert proc { handler_class.build } do
              raises_error?(ArgumentError)
            end
          end
        end
      end

      context "Session is optional positional argument" do
        handler_class = Controls::Handler::SessionArgument::Invalid::Positional::Optional::Example

        context "Given" do
          session = Object.new

          test "Argument error is raised" do
            assert proc { handler_class.build(session: session) } do
              raises_error?(ArgumentError)
            end
          end
        end

        context "Not Given" do
          test "Argument error is raised" do
            assert proc { handler_class.build } do
              raises_error?(ArgumentError)
            end
          end
        end
      end

      context "Session is required keyword argument" do
        handler_class = Controls::Handler::SessionArgument::Invalid::Required::Example

        context "Given" do
          session = Object.new

          test "Argument error is raised" do
            assert proc { handler_class.build(session: session) } do
              raises_error?(ArgumentError)
            end
          end
        end

        context "Not Given" do
          test "Argument error is raised" do
            assert proc { handler_class.build } do
              raises_error?(ArgumentError)
            end
          end
        end
      end
    end
  end
end

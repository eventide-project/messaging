require_relative '../../automated_init'

context "Handle" do
  context "Session Configuration" do
    context "Configure Method Includes Incorrect Session Parameter" do
      context "Session is positional argument" do
        handler_class = Controls::Handler::SessionArgument::Anomaly::Positional::Example

        context "Given" do
          session = Object.new

          test "Argument error is raised" do
            assert_raises(ArgumentError) do
              handler_class.build(session: session)
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

      context "Session is optional positional argument" do
        handler_class = Controls::Handler::SessionArgument::Anomaly::Positional::Optional::Example

        context "Given" do
          session = Object.new

          test "Argument error is raised" do
            assert_raises(ArgumentError) do
              handler_class.build(session: session)
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

      if RUBY_ENGINE == 'mruby'
        _context "Session is required keyword argument (does not work on MRuby 2.x)"
      else
        context "Session is required keyword argument" do
          handler_class = Controls::Handler::SessionArgument::Anomaly::Required::Example

          context "Given" do
            session = Object.new

            test "Argument error is raised" do
              assert_raises(ArgumentError) do
                handler_class.build(session: session)
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

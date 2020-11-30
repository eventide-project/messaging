require_relative '../../automated_init'

context "Handle" do
  context "Settings" do
    context "No Settings" do
      settings = Controls::Settings.example

      handler = Controls::Handler::Settings::Example.build

      context "Settings Attributes" do
        handler_setting_value = handler.some_setting
        control_setting_value = settings.get(:some_setting)

        comment handler_setting_value.inspect
        detail "Control Setting Value: #{control_setting_value.inspect}"

        assert(handler_setting_value.nil?)

        test "Not set" do
          refute(handler_setting_value == control_setting_value)
        end
      end
    end
  end
end

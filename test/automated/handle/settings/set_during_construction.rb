require_relative '../../automated_init'

context "Handle" do
  context "Settings" do
    context "Set During Construction" do
      settings = Controls::Settings.example
      handler = Controls::Handler::Settings::Example.build(settings: settings)

      context "Settings Attributes" do
        handler_setting_value = handler.some_setting
        control_setting_value = settings.get(:some_setting)

        comment handler_setting_value.inspect
        detail "Control Setting Value: #{control_setting_value.inspect}"

        test "Set" do
          assert(handler_setting_value == control_setting_value)
        end
      end

      context "Plain Attributes" do
        handler_attribute_value = handler.some_other_setting
        control_setting_value = settings.get(:some_other_setting)

        comment handler_attribute_value.inspect
        detail "Control Setting Value: #{control_setting_value.inspect}"

        assert(handler_attribute_value.nil?)

        test "Not set" do
          refute(handler_attribute_value == control_setting_value)
        end
      end
    end
  end
end

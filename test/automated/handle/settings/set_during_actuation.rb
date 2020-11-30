require_relative '../../automated_init'

context "Handle" do
  context "Settings" do
    context "Set During Actuation" do
      settings = Controls::Settings.example

      message_data = Controls::MessageData::Read.example

      context "Settings Attributes" do
        test "Set" do
          refute_raises(Controls::Handler::Settings::Error) do
            Controls::Handler::Settings::Example.(message_data, settings: settings)
          end
        end
      end
    end
  end
end

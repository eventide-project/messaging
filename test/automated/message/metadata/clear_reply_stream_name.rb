require_relative '../../automated_init'

context "Message" do
  context "Metadata" do
    context "Clear Reply Stream" do
      metadata = Controls::Metadata.example

      refute(metadata.reply_stream_name.nil?)

      metadata.clear_reply_stream_name

      test "Reply stream attribute value is nil" do
        assert(metadata.reply_stream_name.nil?)
      end
    end
  end
end

require_relative '../../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      message = Controls::Message.example
      reply_stream_name = message.metadata.reply_stream_name

      context "Reply Is Determined to Be Written" do
        writer = Write::Substitute.build

        writer.reply(message)

        context "Detection Predicates" do
          context "No Message Argument" do
            test "No block arguments" do
              assert(writer.replied?)
            end

            test "Message block argument only" do
              assert(writer.replied? { |msg| msg == message })
            end

            test "Message and stream name block arguments" do
              assert(writer.replied? { |msg, stream| stream == reply_stream_name })
            end
          end

          context "Message Argument" do
            test "No block argument" do
              assert(writer.replied?(message))
            end

            test "Stream name block argument" do
              assert(writer.replied?(message) { |stream| stream == reply_stream_name })
            end
          end
        end
      end

      context "Reply Is Determined to Not Be Written" do
        writer = Write::Substitute.build

        context "Detection Predicates" do
          context "No Message Argument" do
            test "No block arguments" do
              refute(writer.replied?)
            end

            test "Message block argument only" do
              refute(writer.replied? { |msg| msg == message })
            end

            test "Message and stream name block arguments" do
              refute(writer.replied? { |msg, stream| stream == reply_stream_name })
            end
          end

          context "Message Argument" do
            test "No block argument" do
              refute(writer.replied?(message))
            end

            test "Stream name block argument" do
              refute(writer.replied?(message) { |stream| stream == reply_stream_name })
            end
          end
        end
      end
    end
  end
end

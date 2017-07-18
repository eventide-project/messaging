require_relative '../../../automated_init'

context "Write" do
  context "Substitute" do
    context "Message" do
      context "Reply" do
        message = Controls::Message.example

        reply_stream_name = message.metadata.reply_stream_name

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

        context "Recorded Data" do
          test "No block arguments" do
            assert(writer.replies.length == 1)
          end

          test "Message block argument only" do
            assert(writer.replies { |msg| msg == message }.length == 1 )
          end

          test "Message and stream name block arguments" do
            assert(writer.replies { |msg, stream| stream == reply_stream_name }.length == 1)
          end
        end

        context "Replied Messages" do
          test "No block arguments" do
            assert(writer.message_replies.length == 1)
          end

          test "Message block argument only" do
            assert(writer.message_replies { |msg| msg == message }.length == 1 )
          end

          test "Message and stream name block arguments" do
            assert(writer.message_replies { |msg, stream| stream == reply_stream_name }.length == 1)
          end
        end

        context "Replied Message" do
          context "More than One Matching Message" do
            duplicate_writer = Write::Substitute.build

            2.times do
              message = Controls::Message.example

              duplicate_writer.reply(message)
            end

            test "Is an error" do
              assert proc { duplicate_writer.one_message_reply { |msg| msg.instance_of?(message.class) }} do
                raises_error? Write::Substitute::Write::Error
              end
            end
          end

          context "One Matching Message" do
            test "No block arguments" do
              assert(writer.one_message_reply == message)
            end

            test "Message block argument only" do
              assert(writer.one_message_reply { |msg| msg == message } == message)
            end

            test "Message and stream name block arguments" do
              assert(writer.one_message_reply { |msg, stream| stream == reply_stream_name } == message)
            end
          end
        end
      end
    end
  end
end

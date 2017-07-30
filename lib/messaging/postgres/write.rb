module Messaging
  module Postgres
    class Write
      include Messaging::Write

      def configure(session: nil)
        MessageStore::Postgres::Write.configure(self, attr_name: :message_writer, session: session)
      end
    end
  end
end

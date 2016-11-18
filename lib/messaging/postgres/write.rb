module Messaging
  module Postgres
    class Write
      include Messaging::Write

      def configure(session: nil)
        EventSource::Postgres::Write.configure(self, attr_name: :event_writer, session: nil)
      end
    end
  end
end

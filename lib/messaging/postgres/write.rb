module Messaging
  module Postgres
    class Write
      include Messaging::Write

      def configure(partition: nil, session: nil)
        EventSource::Postgres::Write.configure(self, attr_name: :event_writer, partition: nil, session: nil)
      end
    end
  end
end

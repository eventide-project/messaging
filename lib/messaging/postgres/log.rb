module Messaging
  module Postgres
    class Log < ::Log
      def tag!(tags)
        tags << :messaging_postgres
      end
    end
  end
end

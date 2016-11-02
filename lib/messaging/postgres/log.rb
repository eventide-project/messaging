module Messaging
  module Postgres
    class Log < ::Log
      def tag!(tags)
        tags << :messaging_postgres
        tags << :library
        tags << :verbose
      end
    end
  end
end

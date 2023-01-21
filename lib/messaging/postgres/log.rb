module Messaging
  module Postgres
    class Log < ::Log
      def tag!(tags)
        tags << :messaging
      end
    end
  end
end

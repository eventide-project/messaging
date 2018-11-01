module Messaging
  class Log < ::Log
    def tag!(tags)
      tags << :messaging
    end
  end
end

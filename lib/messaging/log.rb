module Messaging
  class Log < ::Log
    def tag!(tags)
      tags << :messaging
      tags << :library
      tags << :verbose
    end
  end
end

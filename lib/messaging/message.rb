module Messaging
  module Message
    def self.included(cls)
      cls.send :include, Schema::DataStructure
    end
  end
end

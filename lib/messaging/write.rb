module Messaging
  class Write
    include Log::Dependency

    dependency :event_writer

    def self.build(partition: nil, session: nil)
      instance = new
      instance.configure(partition: partition, session: session)
      instance
    end

    def self.configure(receiver, partition: nil, session: nil, attr_name: nil)
      attr_name ||= :writer
      instance = build(partition: partition, session: session)
      receiver.public_send "#{attr_name}=", instance
    end

    def configure(partition: nil, session: nil)
      EventSource::Postres::Write.configure(self, attr_name: event_writer, partition: partition, session: session)
    end

    def self.call(message, stream_name, partition: nil, session: nil)
    end

    def call(message)
    end
  end
end

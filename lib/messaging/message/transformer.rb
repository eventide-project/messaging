module Messaging
  module Message
    module Transformer
      def self.event_data
        EventData
      end

      def self.raw_data(message)
        message
      end

      module EventData
        def self.write(message)
          event_data = EventSource::EventData::Write.build

          event_data.type = message.message_type

          event_data.data = message.to_h

          metadata = message.metadata.to_h
          metadata.delete_if { |k, v| v.nil? }

          event_data.metadata = metadata

          event_data
        end


      end
    end
  end
end

__END__

module Transformer
  def self.some_format
    SomeFormat
  end

  def self.instance(raw_data)
    instance = Example.new
    instance.some_attribute = raw_data
    instance
  end

  def self.raw_data(instance)
    instance.some_attribute
  end

  module SomeFormat
    def self.write(raw_data)
      Controls::Text.example
    end

    def self.read(text)
      Controls::RawData.example
    end
  end
end

module Messaging
  module Message
    module Transformer
      def self.event_data
        EventData
      end

      def self.raw_data(message)
        message
      end

      def self.instance(event_data_data, cls)
        instance = cls.build(event_data_data[:data], event_data_data[:metadata])
        instance.id = event_data_data[:id]
        instance
      end

      module EventData
        def self.write(message)
          event_data = EventSource::EventData::Write.build

          event_data.id = message.id
          event_data.type = message.message_type

          event_data.data = message.to_h

          metadata = message.metadata.to_h
          metadata.delete_if { |k, v| v.nil? || k == :source_event_stream_name || k == :source_event_position}

          event_data.metadata = metadata

          event_data
        end

        def self.read(event_data)
          data = event_data.to_h

          unless data[:metadata].nil?
            data[:metadata] = data[:metadata].clone
          else
            data[:metadata] = {}
          end

          metadata = data[:metadata]

          metadata[:source_event_stream_name] = data[:stream_name]
          metadata[:source_event_position] = data[:position]

          metadata[:global_position] = data[:global_position]
          metadata[:time] = data[:time]

          data
        end
      end
    end
  end
end

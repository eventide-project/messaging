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
        cls.build(event_data_data[:data], event_data_data[:metadata])
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

        def self.read(event_data)
          data = event_data.to_h

          unless data.has_key?(:metadata)
            data[:metadata] = {}
          end

          metadata = data[:metadata]

          metadata[:source]

          metadata[:source_event_stream_name] = data[:stream_name]
          metadata[:source_event_position] = data[:position]

          metadata[:global_position] = data[:global_position]
          metadata[:recorded_time] = data[:recorded_time]

          data
        end
      end
    end
  end
end

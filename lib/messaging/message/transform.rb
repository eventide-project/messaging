module Messaging
  module Message
    module Transform
      def self.message_data
        MessageData
      end

      def self.raw_data(message)
        message
      end

      def self.instance(message_data_data, cls)
        instance = cls.build(message_data_data[:data], message_data_data[:metadata])
        instance.id = message_data_data[:id]
        instance
      end

      module MessageData
        def self.write(message)
          message_data = MessageStore::MessageData::Write.build

          message_data.id = message.id
          message_data.type = message.message_type

          message_data.data = message.to_h

          metadata = message.metadata.to_h

          if metadata[:properties].empty?
            metadata.delete(:properties)
          end

          if metadata[:local_properties].empty?
            metadata.delete(:local_properties)
          end

          metadata.delete_if { |k, v| v.nil? }

          message_data.metadata = metadata

          message_data
        end

        def self.read(message_data)
          data = message_data.to_h

          if data[:metadata].nil?
            data[:metadata] = {}
          else
            data[:metadata] = data[:metadata].clone
          end

          metadata = data[:metadata]

          metadata[:stream_name] = data[:stream_name]
          metadata[:position] = data[:position]

          metadata[:global_position] = data[:global_position]
          metadata[:time] = data[:time]

          metadata[:properties] ||= {}
          metadata[:local_properties] ||= {}

          data
        end
      end
    end
  end
end

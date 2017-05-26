module Messaging
  module Message
    module Transformer
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
          metadata.delete_if { |k, v| v.nil? }

          message_data.metadata = metadata

          message_data
        end

        def self.read(message_data)
          data = message_data.to_h

          unless data[:metadata].nil?
            data[:metadata] = data[:metadata].clone
          else
            data[:metadata] = {}
          end

          metadata = data[:metadata]

          metadata[:source_message_stream_name] = data[:stream_name]
          metadata[:source_message_position] = data[:position]

          metadata[:global_position] = data[:global_position]
          metadata[:time] = data[:time]

          data
        end
      end
    end
  end
end

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

          properties = metadata[:properties]

          if properties.empty?
            metadata.delete(:properties)
          else
            metadata[:properties] = Properties.write(properties)
          end

          metadata.delete_if { |k, v| v.nil? }

          message_data.metadata = metadata

          message_data
        end

        module Properties
          def self.write(properties)
            properties.map do |property|
              property_hash = property.to_h

              if not property_hash[:local]
                property_hash.delete(:local)
              end

              property_hash
            end
          end
        end

        def self.read(message_data)
          data = message_data.to_h

## TODO change to positive "if"
          unless data[:metadata].nil?
            data[:metadata] = data[:metadata].clone
          else
            data[:metadata] = {}
          end

          metadata = data[:metadata]

          metadata[:stream_name] = data[:stream_name]
          metadata[:position] = data[:position]

          metadata[:global_position] = data[:global_position]
          metadata[:time] = data[:time]

          if metadata[:properties].nil?
            metadata[:properties] = []
          end

          properties = metadata[:properties].map do |property_data|
            Metadata::Property.new(*property_data.values_at(*Metadata::Property.members))
          end

          metadata[:properties] = properties

          data
        end
      end
    end
  end
end

module Messaging
  module Controls
    module Metadata
      def self.example
        data = self.data

        data[:properties] = properties
        data[:local_properties] = local_properties

        Messaging::Message::Metadata.build(data)
      end

      def self.stream_name
        'someSource'
      end

      def self.position
        1
      end

      def self.global_position
        222
      end

      def self.causation_message_stream_name
        "someCausation"
      end

      def self.causation_message_position
        11
      end

      def self.causation_message_global_position
        111
      end

      def self.correlation_stream_name
        "someCorrelation"
      end

      def self.reply_stream_name
        "someReply"
      end

      def self.schema_version
        '1.1'
      end

      def self.identifier
        "#{stream_name}/#{position}"
      end

      def self.causation_message_identifier
        "#{causation_message_stream_name}/#{causation_message_position}"
      end

      def self.properties
        Properties.example
      end

      def self.time
        Time::Raw.example
      end

      def self.properties
        Properties.example
      end

      def self.local_properties
        LocalProperties.example
      end

      def self.data
        {
          stream_name: stream_name,
          position: position,
          global_position: global_position,

          causation_message_stream_name: causation_message_stream_name,
          causation_message_position: causation_message_position,
          causation_message_global_position: causation_message_global_position,

          correlation_stream_name: correlation_stream_name,

          reply_stream_name: reply_stream_name,

          properties: Properties.example,
          local_properties: LocalProperties.example,

          time: time,

          schema_version: schema_version
        }
      end

      module New
        def self.example
          ::Messaging::Message::Metadata.new
        end
      end
      Empty = New

      module Written
        def self.example
          Messaging::Message::Metadata.build(data)
        end

        def self.data
          data = Metadata.data

          Messaging::Message::Metadata.transient_attributes.each do |not_written_attribute|
            data.delete(not_written_attribute)
          end

          data
        end
      end

      module Random
        def self.example
          data = self.data

          data[:properties] = properties
          data[:local_properties] = local_properties

          Messaging::Message::Metadata.build(data)
        end

        def self.stream_name
          Controls::Random::Text.example
        end

        def self.position
          Controls::Random::Number.example
        end

        def self.causation_message_stream_name
          Controls::Random::Text.example
        end

        def self.causation_message_position
          Controls::Random::Number.example
        end

        def self.causation_message_global_position
          Controls::Random::Number.example
        end

        def self.correlation_stream_name
          Controls::Random::Text.example
        end

        def self.reply_stream_name
          Controls::Random::Text.example
        end

        def self.schema_version
          Controls::Random::Number.example.to_s
        end

        def self.identifier
          "#{stream_name}/#{position}"
        end

        def self.causation_message_identifier
          "#{causation_message_stream_name}/#{causation_message_position}"
        end

        def self.global_position
          Controls::Random::Number.example
        end

        def self.time
          (::Time.now + Controls::Random::Number.example).utc
        end

        def self.properties
          Properties::Random.example
        end

        def self.local_properties
          LocalProperties::Random.example
        end

        def self.data
          {
            stream_name: stream_name,
            position: position,
            global_position: global_position,

            causation_message_stream_name: causation_message_stream_name,
            causation_message_position: causation_message_position,
            causation_message_global_position: causation_message_global_position,

            correlation_stream_name: correlation_stream_name,

            reply_stream_name: reply_stream_name,

            properties: Properties::Random.example,
            local_properties: LocalProperties::Random.example,

            time: time,

            schema_version: schema_version
          }
        end
      end
    end
  end
end

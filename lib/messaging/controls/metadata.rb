module Messaging
  module Controls
    module Message
      module Metadata
        def self.example
          ::Messaging::Message::Metadata.build
        end

        def self.source_event_uri
          "streams/sourceStream-#{uuid}/0"
        end

        def self.causation_event_uri
          "streams/causationStream-#{uuid}/0"
        end

        def self.correlation_stream_name
          "correlationStream-#{uuid}"
        end

        def self.reply_stream_name
          "replyStream-#{uuid}"
        end

        def self.schema_version
          11
        end

        def self.initial_stream_name
          "streams/initialStream-#{uuid}/0"
        end

        def self.data
          {
            source_event_uri: Metadata.source_event_uri,
            causation_event_uri: Metadata.causation_event_uri,
            correlation_stream_name: Metadata.correlation_stream_name,
            reply_stream_name: Metadata.reply_stream_name,
            schema_version: Metadata.schema_version
          }
        end

        def self.example
          EventStore::Messaging::Message::Metadata.build data
        end

        module Empty
          def self.example
            EventStore::Messaging::Message::Metadata.build {}
          end
        end

        module JSON
          def self.data
            {
              sourceEventUri: Metadata.causation_event_uri,
              causationEventUri: Metadata.causation_event_uri,
              correlationStreamName: Metadata.correlation_stream_name,
              replyStreamName: Metadata.reply_stream_name,
              schemaVersion: Metadata.schema_version
            }
          end
        end
      end
    end
  end
end

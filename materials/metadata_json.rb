module JSON
  def self.data
    {
      sourceEventStreamName: source_event_stream_name,
      sourceEventPosition: source_event_position,

      causationEventStreamName: causation_event_stream_name,
      causationEventPosition: causation_event_position,

      correlationStreamName: correlation_stream_name,

      replyStreamName: reply_stream_name,

      schemaVersion: schema_version
    }
  end
end

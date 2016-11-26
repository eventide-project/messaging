require_relative 'interactive_init'
require_relative 'controls'

logger = Log.get('Consume')

logger.info "Starting Consumer", tag: :test

stream_name_file = File.expand_path('stream_name.tmp', File.dirname(__FILE__))
stream_name = nil
begin
  stream_name = File.read(stream_name_file)
rescue
  raise "Stream name file is missing (#{stream_name_file}). It's created by the producer script, which must be run concurrently with #{__FILE__}."
end

logger.info "Stream name: #{stream_name}", tag: :test

logger.info "Starting reader", tag: :test

EventSource::Postgres::Read.(stream_name, batch_size: 1, cycle_delay_milliseconds: 10, cycle_timeout_milliseconds: 2000) do |event_data|
  logger.debug event_data.pretty_inspect, tags: [:test, :data, :message]

  message = Handler.(event_data)

  logger.info "Handled message: #{message.message_type}", tags: [:test, :data, :message]

  logger.debug message.pretty_inspect, tags: [:test, :data, :message]
end

require_relative 'interactive_init'
require_relative 'controls'

logger = Log.get('Consume')

logger.level = :debug

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

handler = Handler.build

MessageStore::Read.(stream_name, batch_size: 1, cycle_maximum_milliseconds: 10, cycle_timeout_milliseconds: 2000) do |message_data|
  logger.debug(tags: [:test, :data, :message]) { message_data.pretty_inspect }

  message = handler.(message_data)

  logger.debug(tags: [:test, :data, :message]) { "Handled message: #{message.message_type}" }
  logger.debug(tags: [:test, :data, :message]) { message.pretty_inspect }
end

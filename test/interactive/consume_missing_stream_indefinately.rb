require_relative 'interactive_init'
require_relative 'controls'

logger = Log.get('Consumer')

logger.info "Starting Consumer - Read Indefinitely", tag: :test

stream_name = SecureRandom.hex

logger.info "Stream name: #{stream_name}", tag: :test

logger.info "Starting reader", tag: :test

MessageStore::Read.(stream_name, batch_size: 1, cycle_maximum_milliseconds: 10) {}

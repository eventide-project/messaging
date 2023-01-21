require_relative 'interactive_init'
require_relative 'controls'

logger = Log.get('Produce')

logger.level = :debug

logger.info "Starting Producer", tag: :test

stream_name = Controls::StreamName.example(category: 'testInteractive')
logger.info "Stream name: #{stream_name}", tag: :test

stream_name_file = File.expand_path('stream_name.tmp', File.dirname(__FILE__))

File.write(stream_name_file, stream_name)
logger.debug "Wrote stream name file: #{stream_name_file}", tag: :test

at_exit do
  File.unlink stream_name_file
end

period = ENV['PERIOD']
period ||= 500
period_seconds = Rational(period, 1000)

loop do
  message = SomeMessage.build(written_time: "Written at: #{Clock::UTC.iso8601(precision: 5)}")
  logger.debug message.pretty_inspect, tags: [:test, :data, :message]

  written_position = Write.(message, stream_name)
  logger.debug "Wrote message at position: #{written_position}", tags: [:test, :data, :message]

  sleep period_seconds
end

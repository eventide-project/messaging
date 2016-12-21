require_relative 'interactive_init'
require_relative 'controls'

logger = Log.get('Produce')

logger.level = :info

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
period ||= 0
period_seconds = Rational(period, 1000)

count = 0
start_time = Time.now
1000.times do
  message = SomeMessage.build(written_time: "Written at: #{Clock::UTC.iso8601(precision: 5)}")
  logger.debug message.pretty_inspect, tags: [:test, :data, :message]

  written_position = Write.(message, stream_name)
  count += 1
  logger.debug "Wrote message ##{count} at position: #{written_position}", tags: [:test, :data, :message]

  sleep period_seconds
end

stop_time = Time.now

duration = stop_time - start_time
throughput = count / duration

logger.info "Messages: #{count}", tags: [:test, :data, :message]
logger.info "Duration: #{duration}", tags: [:test, :data, :message]
logger.info "Throughput: #{throughput}", tags: [:test, :data, :message]

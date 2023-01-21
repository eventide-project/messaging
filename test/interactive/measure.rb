require_relative 'interactive_init'
require_relative 'controls'

producer_logger = Log.get('Produce')
producer_logger.level = :info
producer_logger.info "Starting Producer", tag: :test

stream_name = Controls::StreamName.example(category: 'testInteractive')
producer_logger.info "Stream name: #{stream_name}", tag: :test

period = ENV['PERIOD']
period ||= 0
period_seconds = Rational(period, 1000)

producer_count = 0
producer_start_time = Time.now
1000.times do
  message = SomeMessage.build(written_time: "Written at: #{Clock::UTC.iso8601(precision: 5)}")
  producer_logger.debug message.pretty_inspect, tags: [:test, :data, :message]

  written_position = Write.(message, stream_name)
  producer_count += 1
  producer_logger.debug "Wrote message ##{producer_count} at position: #{written_position}", tags: [:test, :data, :message]

  sleep period_seconds
end

producer_stop_time = Time.now


consumer_logger = Log.get('Consume')
consumer_logger.level = :info
consumer_logger.info "Starting Consumer", tag: :test

consumer_logger.info "Stream name: #{stream_name}", tag: :test

consumer_logger.info "Starting reader", tag: :test

handler = Handler.build

consumer_count = 0
consumer_start_time = Time.now
MessageStore::Read.(stream_name) do |message_data|
  consumer_logger.debug(tags: [:test, :data, :message]) { message_data.pretty_inspect }

  message = handler.(message_data)
  consumer_count += 1

  consumer_logger.debug(tags: [:test, :data, :message]) { "Handled message: #{message.message_type}" }
  consumer_logger.debug(tags: [:test, :data, :message]) { message.pretty_inspect }
end

consumer_stop_time = Time.now


producer_duration = producer_stop_time - producer_start_time
producer_throughput = producer_count / producer_duration

producer_logger.info "Messages: #{producer_count}", tags: [:test, :data, :message]
producer_logger.info "Duration: #{producer_duration}", tags: [:test, :data, :message]
producer_logger.info "Throughput: #{producer_throughput}", tags: [:test, :data, :message]


consumer_duration = consumer_stop_time - consumer_start_time
consumer_throughput = consumer_count / consumer_duration

consumer_logger.info "Messages: #{consumer_count}", tags: [:test, :data, :message]
consumer_logger.info "Duration: #{consumer_duration}", tags: [:test, :data, :message]
consumer_logger.info "Throughput: #{consumer_throughput}", tags: [:test, :data, :message]


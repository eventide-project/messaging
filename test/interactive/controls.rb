require_relative 'interactive_init'

class SomeMessage
  include Messaging::Message

  attribute :written_time
  attribute :handled_time
end

class Handler
  include Messaging::Handle

  handle SomeMessage do |some_message|
    some_message.handled_time = "Handled at: #{Clock::UTC.iso8601(precision: 5)}"
  end
end

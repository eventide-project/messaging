# messaging

Messaging primitives for Eventide

## Event Data


## Messages

A message is a data structure used to communicate within a system. Typically, these are divided into two categories: commands and events. Commands are used to communicate between services (i.e. tell, don't ask). A service will tell another service to perform an action by issuing a command to that service. Events are used to record *things that have happened*. A service will record events to serve as an audit log and a source of truth for application state. You can read more about commands v. events [here](http://eventide-project.org/quick_look.html)

### Constructing a Message Class
To create a message, include the module `Messaging::Message` in your message class. The message type comes from the message class. The message name is an underscore cased version of the message type, which is used when processing messages. Commands are typically named in the imperative, present tense (e.g. `Deposit`) while Events are typicaly named in the past tense (e.g. `Deposited`). As an example, we will create an event message but constructing a command message is no different.

Message attributes are the data that a message contains. Stongly typed messages are not required, but are recommended. Attribute types are defined inline with the message attribute. Default values can be set if desired.

```ruby
class Deposited
  include Messaging::Message

  attribute :account_id, String
  attribute :amount, Integer, :default => 0
  attribute :time, String
  attribute :processed_time, String
end

message = Deposited.new

message.message_type == 'Deposited'
# => true
message.message_name == 'deposited'
# => true

message.account_id.nil?
# => true
message.amount == 0
# => true
```

If a message is created using the `new` method, attributes must be set separately. Using the `build` method, a message can be built with a hash and each message attribute matching a key in the hash will be set to the value in the hash.

```ruby
account_id = Identifier::UUID::Random.get
hash = {
  account_id: account_id,
  amount: 123,
  time: '2000-01-01T00:00:00.001Z',
  processed_time: '2000-01-01T00:00:00.001Z'
}

message = Deposited.build hash
message.account_id == account_id
# => true
message.amount == 123
# => true
...
```

## Metadata

By including `Messaging::Message`, a message is provided with an additional `metadata` attribute to store infrastructural data about the message. The following attributes are part of the `Messaging::Message::Metadata` data structure:

- `:source_event_stream_name` - This is the stream name that the source event, or the current message, was written to. It can also be accessed using the `:stream_name` attribute
- `:source_event_position` - This is the position of the current event in its event stream. The position is an auto-incrementing integer that is unique to each event in a stream. It can also be accessed using the `:sequence' or `:position` attributes
- `:causation_event_stream_name` - If the current message is part of a process and follows another event in that process, this will provide the stream name of the causation event. The causation event is the message directly preceding the current message in a process, or the message that caused the current event to be written. This can be the same as the `:source_event_stream_name`, but often is not. If the current message is not part of a process or if it is the first message in the process, this will not be set as there is no causation event
- `:causation_event_position` - This is the position of the causation event in the `causation_event_stream`. This will not be set if there is no causation event
- `:correlation_stream_name` - This is the stream name of the correlating stream, or the overarching process. For example, a Funds Transfer will need to instantiate the `Deposit` and `Withdraw` commands of the Account process. All of the messages in the `FundsTransfer` service and the `Account` service that relate to that specific Funds Transfer will have the same correlation stream name (i.e. `fundsTransfer-#{transfer_id}`)
- `:global_position` - The global position is the position in the category stream name of the event. For example, the position of an event would be the position within the events for a specific Funds Transfer, identified by a specific transfer ID. The global position would be the position within all of the events of the Funds Transfer process, not specific to any transfer IDs. This is also an auto-incrementing integer and will always be greater than or equal to the source event position
- `:time` - The time the message was saved in the database. This is not meant to replace a timestamp in the message body- this will change any time a message is copied or rewritten, whereas a timestamp message attribute will always reflect the time the event was constructed
- `:reply_stream_name` - When a process issues a command to another process, the original process can provide a reply stream name. When the other process has completed the request, it will reply to the original process with the result of the command (i.e. a FundsTransfer may receive a `RecordDeposited` reply from the Account service). The original process can then continue knowing that the command was completed successfully or unsucessfully and act accordingly

build w/ metadata
copy w/ metadata

## General Use

## Use with EventStore

## Use with Postgres

## License

The `messaging` library is released under the [MIT License](https://github.com/eventide-project/messaging/blob/master/MIT-License.txt).

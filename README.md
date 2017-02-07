# messaging

Messaging primitives for Eventide

## Messages

A message is a data structure used to communicate within a system. Typically, these are divided into two categories: commands and events. Commands are used to communicate between services (i.e. tell, don't ask). A service will tell another service to perform an action by issuing a command to that service. Events are used to record *things that have happened*. A service will record events to serve as an audit log and a source of truth for application state. You can read more about commands v. events [here](http://eventide-project.org/quick_look.html).

### Initializing a Message
To create a message, include the module `Messaging::Message` in your message class. The message type comes from the message class. The message name is an underscore-case version of the message type, which is used when processing messages. Commands are typically named in the imperative, present tense (e.g. `Deposit`) while Events are typicaly named in the past tense (e.g. `Deposited`). An example event message is shown below, but constructing a command message is no different.

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

### Message Metadata

By including `Messaging::Message`, a message is provided with an additional `metadata` attribute to store infrastructural data about the message. The following attributes are part of the `Messaging::Message::Metadata` data structure:

- `:source_event_stream_name` - This is the stream name that the source event, or the current message, was written to. It can also be accessed using the `:stream_name` attribute
- `:source_event_position` - This is the position of the current event in its event stream. The position is an auto-incrementing integer that is unique to each event in a stream. It can also be accessed using the `:sequence' or `:position` attributes
- `:causation_event_stream_name` - If the current message is part of a process and follows another event in that process, this will provide the stream name of the causation event. The causation event is the message directly preceding the current message in a process, or the message that caused the current event to be written. This can be the same as the `:source_event_stream_name`, but often is not. If the current message is not part of a process or if it is the first message in the process, this will not be set as there is no causation event
- `:causation_event_position` - This is the position of the causation event in the `causation_event_stream`. This will not be set if there is no causation event
- `:correlation_stream_name` - This is the stream name of the correlating stream, or the overarching process. For example, a Funds Transfer will need to instantiate the `Deposit` and `Withdraw` commands of the Account process. All of the messages in the `FundsTransfer` service and the `Account` service that relate to that specific Funds Transfer will have the same correlation stream name (e.g. `fundsTransfer-#{transfer_id}`)
- `:global_position` - The global position is the position in the category stream name of the event. For example, the position of an event would be the position within the events for a specific Funds Transfer, identified by a specific transfer ID. The global position would be the position within all of the events of the Funds Transfer process, not specific to any transfer IDs. This is also an auto-incrementing integer and will always be greater than or equal to the source event position
- `:time` - The time the message was saved in the database. This is not meant to replace a timestamp in the message body- this will change any time a message is copied or rewritten, whereas a timestamp message attribute will always reflect the time the event was constructed
- `:reply_stream_name` - When a process issues a command to another process, the original process can provide a reply stream name. When the other process has completed the request, it will reply to the original process with the result of the command (e.g. a FundsTransfer may receive a `RecordDeposited` reply from the Account service). The original process can then continue knowing that the command was completed successfully or unsucessfully and act accordingly

### Message Constructors

When a message is built using the standard `build` method, the metadata is initialized to an empty `Messaging::Message::Metadata` data strucure. To set or transfer metadata from one message to another, metadata must be taken into consideration when building the message. This is specifially related to the `source_event_stream_name`, `source_event_position`, `causation_event_stream_name`, `causation_event_position`, `correlation_stream_name`, and `reply_stream_name` attributes. The `global_position` and `time` attibutes are set when writing the message to the database and are independent of any related message metadata.

#### #build

A `build` contructor method is provided as a convenience for creating a new message. It takes two optional parameters- data and metadata. If a message is created using the `new` method, attributes must be set separately. By passing in a data parameter to the `build` method, each message attribute matching a key in the data hash will be set to the value in the hash:

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

The second, optional metadata parameter works the same way. Any values provided as part of the metadata hash will be set to the matching metadata attributes. This is generally used for testing and control data purposes- the `follow` method provides more value in a production setting.

#### #correlate

When constructing the first message in a process, it is vital to set the correlation stream name so that it can be propagated to all additional messages in the process. The `correlate` method provides that convenience:

```ruby
correlation_stream_name = "fundsTransfer-#{Identifier::UUID::Random.get}"

message = Deposited.correlate correlation_stream_name
message.metadata.correlation_stream_name == correlation_stream_name
# => true
```

#### #follow

A message can also be constructed using the `follow` method. This method serves two major purposes:
1. Translates relevant metadata from preceding message to subsequent message
2. Provides optionality in transferring message attributes

##### Translating Metadata

When constructing subsequent messages in a process, it is important not to lose the metadata from the preceding event when constructing the next event in the process. The `follow` method takes that in to consideration. By passing in the preceding message, the message being constructed is built with the relevant metadata already set. The `source_event_stream_name` and `source_event_position` of the preceding event are used as the `causatation_stream_name` and the `causation_event_position` of the new message. The `reply_stream_name` and `correlation_stream_name` are copied

```ruby
message = Deposited.follow deposit_command
message.metadata.causation_stream_name == deposit_command.metadata.source_stream_name
# => true
message.metadata.causation_position == deposit_command.metadata.source_event_position
# => true
message.metadata.reply_stream_name == deposit_command.metadata.reply_stream_name
# => true
message.metadata.correlation_stream_name == deposit_command.metadata.correlation_stream_name
# => true
```

##### Transferring Message Attributes

If the message being constructed has all of the same attributes as the preceding message, the `follow` method can copy all of those attributes at construction:

```ruby
message = Deposited.follow deposit_command, copy: true
```

If certain attributes should be copied, specifiy those using `include`:

```ruby
message = Deposited.follow deposit_command, include: [:deposit_id, :account_id, :amount]
```

If certain attributes should not be copied, specifiy those using `exclude`:

```ruby
message = Deposited.follow deposit_command, exclude: [:time]
```

## Handling Messages

Messages are data structures- they contain the information needed to perform logic. The handlers are where the logic is performed and the flow of the process is determined using the message data. The logic can be incredibly simple or complex depending on the message being handled.

To construct a handler, simply include the `Messaging::Handle` module in the handler class. Using the defined `handle` methods that this module provides, you can specifcy which events to address in a particular handler. A handler can handle one or many events, depending on how you decide to organize your code.

Here is a simple example of a handler for the `Transfer` command issued to the `TransferFunds` component. Example `Transfer` and `Initiated` messages are also defined:

```ruby
module Messages
  module Commands
    class Transfer
      include Messaging::Message

      attribute :transfer_id, String
      attribute :amount, Integer
      attribute :source_account_id, String
      attribute :destination_account_id, String
      attribute :time, String
    end
  end

  module Events
    class Initiated
      attribute :transfer_id, String
      attribute :amount, Integer
      attribute :source_account_id, String
      attribute :destination_account_id, String
      attribute :time, String
    end
  end
end

module Handlers
  class Transfer
    include Messaging::Handle

    def configure
      Messaging::Postgres::Write.configure self
    end

    handle Transfer do |transfer|
      transfer_id = transfer.transfer_id

      initiated = Initiated.follow transfer, exclude: [:time]
      initiated.time = Time.now

      stream_name = "transferFunds-#{transfer_id}"
      writer.(initiated, stream_name)
    end
  end
end
```

In this example, the handler is taking a message issued by an external process- the `Transfer` command- and initiating an internal process by writing the `Initiated` event. Another handler would be written to handle the `Initiated` message and so on until the process is completed. A process is complete when there are no more messages to write or when a written message does not need to be handled.

A handler class can configure additional dependencies using the optional `configure` method provided by the `Messaging::Handle` module. This method will be called during construction of the handler.

## Database-Specific Messaging

The `messaging` library is the generic messaging interface for the Eventide framework. For messaging primitives that are database-specific, such as stream name construction and message writers, see our supported database libraries:

- [messaging-event_store](https://github.com/eventide-project/messaging-postgres)
- [messaging-postgres](https://github.com/eventide-project/messaging-event-store)

## License

The `messaging` library is released under the [MIT License](https://github.com/eventide-project/messaging/blob/master/MIT-License.txt).

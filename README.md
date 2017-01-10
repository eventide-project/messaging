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
  attribute :amount, Numeric, :default => 0
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

If a message is created using the initializer, attributes must be set separately. Using the `build` method, a message can be built with a hash and each message attribute matching a key in the hash will be set to the value in the hash.

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
```

## Metadata
build w/ metadata
copy w/ metadata

## General Use

## Use with EventStore

## Use with Postgres

## License

The `messaging` library is released under the [MIT License](https://github.com/eventide-project/messaging/blob/master/MIT-License.txt).

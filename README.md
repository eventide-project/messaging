# messaging-postgres

Postgres messaging for Eventide

## Summary

The `messaging-postgres` library contains primitives for writing and reading messages, as well as message handlers and mixins for message schemas and stream name utilities.

## Example

```ruby
account_id = ‘123’

deposit = Deposit.new
deposit.account_id = account_id
deposit.amount = 11

stream_name = StreamName.stream_name(account_id, 'account')
# => 'account-123'

Messaging::Postgres::Write.(deposit, stream_name)

Messaging::Postgres::Read.(stream_name) do |message_data|
  AccountComponent::Handlers::Command.(message_data)
end
```

## Elements

### Handlers

A Handler is the mechanism that receives messages, and takes action based on them.

By including `Messaging::Handle`, a class becomes a handler. By including `Messaging::Postgres::StreamName` the handler class receives some useful utilities for composing stream names from constituent parts (category and an entity's ID), and for declaring a the category name that the handler is concerned with (eg: `account`, `fundsTransfer`, `userProfile`, etc).

```ruby
module AccountComponent
  module Handlers
    class Commands
      include Messaging::Handle
      include Messaging::Postgres::StreamName

      category :account

      handle Deposit do |deposit|
        account_id = deposit.account_id

        time = clock.iso8601

        deposited = Deposited.follow(deposit)

        stream_name = stream_name(account_id)

        write.(deposited, stream_name, expected_version: version)
      end
    end
  end
end
```

### Messages

Messages are typically simplistic data structures that carry instructions and responses to and from services.

By including `Messaging::Message`, a message class can declare attributes that will become part of a message's payload.

```ruby
module AccountComponent
  module Messages
    module Commands
      class Deposit
        include Messaging::Message

        attribute :deposit_id, String
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
      end
    end
  end
end

deposit = AccountComponent::Messages::Commands::Deposit.new

deposit.deposit_id = Identifier::UUID::Random.get
deposit.account_id = account_id
deposit.amount = 11
deposit.time = clock.iso8601
```

### Reading Messages

The `Messaging::Postgres::Read` class provides access to streams stored in Postgres. The reader takes a block that receives raw _message data_, and executes the block for each message data received.

```ruby
stream_name = 'account-123'

Messaging::Postgres::Read.(stream_name) do |message_data|
  puts message_data.type
end
```

### Writing Messages

The `Messaging::Postgres::Write` class writes a message to a stream. The message is converted to raw _message data_ first, then written to the data store.

```ruby
deposit = AccountComponent::Messages::Commands::Deposit.new

deposit.deposit_id = Identifier::UUID::Random.get
deposit.account_id = account_id
deposit.amount = 11
deposit.time = clock.iso8601

stream_name = 'account-123'

Messaging::Postgres::Write.(deposit, stream_name)
```

## Detailed Examples

For a more in-depth example of the use of this library, see the example projects in the Eventide Examples org on GitHub: https://github.com/eventide-examples

## Complete Documentation

The complete Eventide project documentation can be found at http://eventide-project.org

## License

The `messaging-postgres` library is released under the [MIT License](https://github.com/eventide-project/messaging-postgres/blob/master/MIT-License.txt).

require_relative "init"

require "message_store/postgres/controls"

stream_name = "someStream-1"

write = MessageStore::Postgres::Write.build

10_000.times do
  messages = 5.times.map do
    MessageStore::Postgres::Controls::MessageData::Write.example
  end

  write.(messages, stream_name)
end

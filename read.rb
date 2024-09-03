require_relative "init"

stream_name = "someStream-1"

position = -1

session = MessageStore::Postgres::Session.build

loop do
  read = MessageStore::Postgres::Read.build(stream_name, position: position + 1, batch_size: 10, session:)

  read.() do |message|
    new_position = message.position

    if new_position != position + 1
      puts "Gap detected (Position: #{position}, New Position: #{new_position})"
      return
    end
    position = new_position
  end
end

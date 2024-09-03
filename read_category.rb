require_relative "init"

category = "someStream"

position = 0

session = MessageStore::Postgres::Session.build

loop do
  read = MessageStore::Postgres::Read.build(category, position: position + 1, batch_size: 100, session:)

  read.() do |message|
    new_position = message.global_position

    if new_position != position + 1
      puts "Gap detected (Position: #{position}, New Position: #{new_position})"
      return
    end
    position = new_position
  end
end

require "http/server"
require "json"

people = People.new(Array(Person).new, Mutex.new)

server = HTTP::Server.new do |context|
  if context.request.method == "GET"
    people.mu.lock
    people.people.to_json context.response
    people.mu.unlock
  end
  if context.request.method == "POST"
    if body = context.request.body
      new_person = Person.from_json(body.gets_to_end)
      people.mu.lock
      people.people.push(new_person)
      people.mu.unlock
    end
  end
end

address = server.bind_tcp 3000
server.listen

struct Person
  include JSON::Serializable
  
  property name, email, residences

  def initialize(@name : String, @email : String, @residences : Array(Address))
  end
end

struct Address
  include JSON::Serializable

  property street, city, country

  def initialize(@street : String, @city : String, @country : String)
  end
end

struct People
  property people, mu

  def initialize(@people : Array(Person), @mu : Mutex)
  end
end
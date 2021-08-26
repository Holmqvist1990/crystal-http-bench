require "http/server"
require "json"

people = Array(Person).new

server = HTTP::Server.new do |context|
  if context.request.method == "GET"
    people.to_json context.response
  end
  if context.request.method == "POST"
    if body = context.request.body
      new_person = Person.from_json(body.gets_to_end)
      people.push(new_person)
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
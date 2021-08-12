require "http/server"
require "json"

# -------------------------------------------------------------------------- #
#                               BENCHMARK TEST                               #
# -------------------------------------------------------------------------- #
# 1. Deserialize JSON from wire.                                             #
#         {"from": "steve", "url": "/steve", "text": "hello"}.               #
# 2. Insert into hash if text is new, no duplicates.                         #
#         [from][url].push(text)                                             #
# 3. Done.                                                                   #
# -------------------------------------------------------------------------- #

hash = HTextHash.new

server = HTTP::Server.new do |context|
  unless context.request.method == "POST"
    next
  end
  if body = context.request.body
    new_item = HText.from_json(body.gets_to_end)
    hash.insert(new_item)
  end
end

address = server.bind_tcp 8080
puts "Listening on http://#{address}"
server.listen

struct HText
  include JSON::Serializable
  
  property from, url, text

  def initialize(@from : String, @url : String, @text : String)
  end
end

struct HTexts
  property from, url, texts

  def initialize(@from : String, @url : String, @texts : Array(String))
  end
  
  def to_s
    "From: #{@from}\nTexts: #{@texts}\nURL: #{@url}\n"
  end
end

class HTextHash
  property hash

  def initialize
    @hash = Hash(String, Hash(String, HTexts)).new
  end

  def insert(ht : HText) : Bool
    unless @hash[ht.from]?
      @hash[ht.from] = Hash(String, HTexts).new
    end
    
    unless @hash[ht.from][ht.url]?
      new_ht = HTexts.new(ht.from, ht.url, [ht.text])
      @hash[ht.from][ht.url] = new_ht
      return true
    end

    res = @hash[ht.from][ht.url]
    
    if res.texts.any?{ |text| text == ht.text }
      return false
    end

    res.texts.push(ht.text)

    @hash[ht.from][ht.url] = res

    return true
  end

  def get(ht : HText) : HTexts?
    if from = @hash[ht.from]
      return from[ht.url]?
    end
    
    return nil
  end
end

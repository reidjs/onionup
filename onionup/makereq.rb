require './tor/http'
require './tor/configuration'
require './tor/tor_requests'

res = Tor::HTTP.get("8.8.8.8", "/", 80)

p res.code
p res.body

res = Tor::HTTP.post('posttestserver.com', {"var" => "variable"}, '/post.php?dir=example', 80)
p res.code
p res.body

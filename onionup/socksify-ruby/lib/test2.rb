require 'socksify/http'
uri = URI.parse('http://answerstedhctbek.onion/')
Net::HTTP.SOCKSProxy('127.0.0.1', 9050).start(uri.host, uri.port) do |http|
  p http.get(uri.path)
end

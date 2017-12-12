require 'socksify/http'
uri = URI.parse('http://answerstedhctbek.onion/')
Net::HTTP.SOCKSProxy(ENV['TOR_IP'], 9050).start(uri.host, uri.port) do |http|
  p http.get(uri.path)
end

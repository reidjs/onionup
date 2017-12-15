require 'socksify/http'

class Site < ApplicationRecord
  validates :url, presence: true
  
  belongs_to :user
  has_many :pings

  def ping
    responseTime = 0
    loadTime = 0
    status = false
    loaded = false
    uri = URI.parse(self.url)
      begin
        puts "started socks request!  url: " + self.url
        a = Time.now
        Net::HTTP.SOCKSProxy(ENV['TOR_IP'], 9050).start(uri.host, uri.port, open_timeout:10) do |http|
          b = Time.now
          status = true
          responseTime =  (b-a)*1000
          http.read_timeout = 10
          http.open_timeout = 10
          begin
            a = Time.now
            res = http.get(uri)
            b = Time.now
            loaded = true
            loadTime = (b-a)*1000
          rescue
            return {responseTime:responseTime, loadTime:loadTime, status: status, loaded:loaded}
          end

          
        end
        return {responseTime:responseTime, loadTime:loadTime, status: status, loaded:status}

      rescue
        puts "Host unreachable error"
      end
      b=Time.now
      responseTime =  (b-a)*1000
    return {responseTime:responseTime, loadTime:loadTime, status: status, loaded: loaded}
  end
end

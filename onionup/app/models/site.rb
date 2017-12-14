require 'socksify/http'

class Site < ApplicationRecord
  belongs_to :user
  has_many :pings

  def ping
    uri = URI.parse(self.url)

    # if !uri.host.nil? && uri.path
      begin
        puts "started socks request!  id: "
        p self.id
        Net::HTTP.SOCKSProxy(ENV['TOR_IP'], 9050).start(uri.host, uri.port) do |http|
          p http
          a = Time.now
          
          begin
           res = Net::HTTP.SOCKSProxy(ENV['TOR_IP'], 9050).get_response(uri)
            p res.body
            p 'succes get' 
            p self.id 
          rescue
            p 'no get ' 
            p self.id
          end
          b = Time.now
          p b-a

          return true
        end
          # p 
        # return true
      rescue
        puts "Host unreachable error"
      end
    # end
    false
  end
end

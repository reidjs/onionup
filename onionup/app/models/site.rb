require 'socksify/http'

class Site < ApplicationRecord
  belongs_to :user
  has_many :pings

  def ping
    uri = URI.parse(self.url)
    # if !uri.host.nil? && uri.path
      begin
        puts "started socks request"
        Net::HTTP.SOCKSProxy('127.0.0.1', 9050).start(uri.host, uri.port) do |http|
          return true
        end
          # p http.get(uri.path)
        # return true
      rescue
        puts "Host unreachable error"
      end
    # end
    false
  end
end

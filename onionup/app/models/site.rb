require 'socksify/http'
require 'byebug'
class Site < ApplicationRecord
  belongs_to :user

  def ping
    uri = URI.parse(self.url)
    # if !uri.host.nil? && uri.path
      begin
        puts uri.host
        puts uri.port
        Net::HTTP.SOCKSProxy('54.172.67.164', 9050).start(uri.host, uri.port) do |http|
          return true
        end
          p http.get(uri.path)
        # return true
      rescue
        puts "Host unreachable error"
      end
    # end
    false
  end
end

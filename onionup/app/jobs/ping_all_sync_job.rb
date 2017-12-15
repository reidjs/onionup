class PingAllSyncJob < ApplicationJob
  queue_as :default

  def perform()
    sites = Site.all
    #make threadsafe pings queueMultithreads didnt like me instantiating Ping.new() inside a thread
    sites.each do |site|
        Ping.new
        ping = Ping.new
        ping.site_id = site.id
        res = site.ping
        p res
        ping.responseTime = res[:responseTime]
        ping.status = res[:status]
        ping.loaded = res[:loaded]
        ping.loadTime = res[:loadTime]
        ping.save
    end
  end
end

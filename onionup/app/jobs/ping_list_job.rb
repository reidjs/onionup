class PingListJob < ApplicationJob
  queue_as :default

  def perform(list)
    @sites = list
    #make threadsafe pings queueMultithreads didnt like me instantiating Ping.new() inside a thread
    pings = Queue.new
    finished_pings = Queue.new
    @sites.each do |site| 
      pings << Ping.new
    end
    #make new thread for every site: get a new ping, ping the site, apply attributes to ping 
    #pretty sure the threadsafe queues are what made this work. 
    threads = @sites.map do |site|
      Thread.new do
          Ping.new
          ping = pings.pop
          ping.site_id = site.id
          res = site.ping
          p res
          ping.responseTime = res[:responseTime]
          ping.status = res[:status]
          ping.loaded = res[:loaded]
          ping.loadTime = res[:loadTime]
          finished_pings.push(ping)

      end
    end
    #wait for threads to finish

    threads.each{|thr| thr.join}    
    while (!finished_pings.empty?)
      finished_pings.pop(true).save!
    end
  end

end

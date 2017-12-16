

namespace :ping do
        desc "ping all sites concurrently"
    task :multi => :environment do
        PingAllJob.new.perform()
    end
        desc "ping all sites single threadedly"
    task :sync => :environment do
        PingAllSyncJob.new.perform()
    end
end

namespace :clean do
    desc "delete all pings older than now"
    task :now => :environment do
        puts "this"
        RemoveOldPingsJob.new.perform(0)
    end
    desc "delete all pings older than 1 day"
    task :day => :environment do
        puts "this"
        RemoveOldPingsJob.new.perform(1)
    end
        desc "delete all pings older than 30 days"
    task :month => :environment do
        puts "this"
        RemoveOldPingsJob.new.perform(30)
    end
end



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
    desc "delete all pings older than parameter. Call like clean:older_than[30] to delete all older than 30 days"
    task :older_than,[:day] => :environment do |t,args|
        days = args[:day].to_i
        RemoveOldPingsJob.new.perform(days)
    end

    desc "delete all pings older than now"
    task :now,[:day] => :environment do |t,args|
        puts args[:day].to_i==2
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

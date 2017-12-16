desc "This task is called by the Heroku scheduler add-on"
task :development => :environment do
  puts "Updating feed..."
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end
class TestjobJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "I AM A ACTIVE:JOB."
    a=Ping.new(site_id:1, status:false)
    a.save!
    puts args
  end



end
  # TestjobJob.new.perform("hi")
  # TestjobJob.perform_async('bob', 5)
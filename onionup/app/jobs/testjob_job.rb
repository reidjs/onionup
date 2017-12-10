class TestjobJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "I AM A ACTIVE:JOB. I HAVE BEEN SHARPENING MY SKILLS"
    puts args
  end

  TestjobJob.perform_now("world")
end

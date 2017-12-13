require 'thread'

class PingAllJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @sites = Site.all
    PingListJob.new.perform(@sites)
  end
end
# PingAllJob.new.perform("hi")
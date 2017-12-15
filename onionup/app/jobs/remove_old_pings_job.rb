class RemoveOldPingsJob < ApplicationJob
  queue_as :default

  def perform(oldestPermitted)
    time = DateTime.now-oldestPermitted
    oldPings = Ping.where("created_at <= ?",time)
    oldPings.each{|ping| ping.delete}
  end
end

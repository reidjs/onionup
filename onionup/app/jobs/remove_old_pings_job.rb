class RemoveOldPingsJob < ApplicationJob
  queue_as :default

  def perform(OldestPermitted)
    time = DateTime.now-OldestPermitted
    oldPings = Ping.where("created_at <= ?",time)
    oldPings.each{|ping| ping.delete}
  end
end

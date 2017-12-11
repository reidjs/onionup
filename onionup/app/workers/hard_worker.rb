# class HardWorker
#   include Sidekiq::Worker

#     def perform(*args)
#       logger.info "Things are happening."
#     logger.debug "Here's some info:"
#     puts "I AM A WORKER."
#     a=Ping.new()
#     a.save
#     a=Ping.new(site_id:1, status:false)
#     a.save!
#     puts args
#   end

# end

# puts "here"
  # HardWorker.perform_async('bob', 5)
  # HardWorker.new.perform("hi")

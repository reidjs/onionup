require 'thread'

class Api::SitesController < ApplicationController
    before_action :authenticate_user!

  def show_ping
    @site = Site.find_by(id: params[:id])
    ping = Ping.new(site_id: @site.id)
    if (@site.ping)
        ping.status = true;
      else
        ping.status = false;
    end
    ping.save! ############################## remove
    render json:[[@site], [@site.pings]]
  end

  def index_ping
    # @sites = current_user.sites
    # queue = Queue.new
    # pings = Queue.new
    # finished_ping = Queue.new

    # @sites.each do |site| 
    #   queue << site 
    #   pings << Ping.new
    # end

    # threads = @sites.map do |site|
    #   Thread.new do
    #     puts "new thread"
    #     puts "here1"
    #       puts "here2"
    #       puts 'here3'
    #       ping = pings.pop
    #       ping.site_id = site.id
    #       puts "here4"
    #       if (site.ping)
    #         ping.status = true;
    #       else
    #         ping.status = false;
    #       end
    #       puts Thread.current
    #       puts site

    #       finished_ping.push(ping)
    #                 puts "here5"
    #       # Thread.current.exit
    #   end
    # end


    # puts "after thread start"
    # puts threads.count
    # threads.each{|thr| thr.join}
    # puts "after thread join"
    
    # while (!finished_ping.empty?)
    #   finished_ping.pop(true).save!
    # end
    # @pings = @sites.map{|site| site.pings}
    # render json:[[@sites],[@pings]]








    @sites = current_user.sites
    @sites.each do |site|
      ping = Ping.new(site_id: site.id)
      if (site.ping)
        ping.assign_attributes(status:true)
        puts "here"
        puts ping.status
      else
        ping.assign_attributes(status:false)
        puts "here1"
        puts ping.status
      end
      puts ping.status
      ping.save! ######################### take out ! 
    end
      @pings = @sites.map{|site| site.pings}
      render json:[[@sites],[@pings]]
  end

  def index
    @sites = current_user.sites
    @pings = @sites.map{|site| site.pings}
      render json:[[@sites],[@pings]]
  end

  def show
    @site = Site.find_by(id: params[:id])
    render json:[[@site],[@site.pings]]
  end

  # def create
  #   @site = Site.new(site_params)
  #   @site.user_id = current_user.id
  #   if @site.save
  #     render json: @site
  #   #  render "api/events/show"
  #   else
  #     render json: @site.errors.full_messages
  #     return
  #   end
  #   # fail
  # end

  # def destroy
  #   @site = Site.find_by(id: params[:id])
  #   if !@site
  #     render
  #     return
  #   elsif @site.destroy
  #     redirect_to sites_url
  #     return
  #   else
  #     flash.now[:errors] = @site.errors.full_messages
  #     return
  #   end
  # end
  private

  def site_params
    params.require(:site).permit(:url)
  end
end

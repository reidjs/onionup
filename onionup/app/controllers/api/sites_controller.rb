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
    # get current users sites
    @sites = current_user.sites
    #make threadsafe pings queue and finished pings queu. Multithreads didnt like me instantiating Ping.new() inside a thread
    pings = Queue.new
    finished_ping = Queue.new
    @sites.each do |site| 
      pings << Ping.new
    end
    #make new thread for every site: get a new ping, ping the site, apply attributes to ping and put it in finished_ping queue
    #pretty sure the threadsafe queues are what made this work. 
    threads = @sites.map do |site|
      Thread.new do
          ping = pings.pop
          ping.site_id = site.id
          if (site.ping)
            ping.status = true;
          else
            ping.status = false;
          end
          finished_ping.push(ping)
      end
    end
    #wait for threads to finish
    threads.each{|thr| thr.join}    
    #save every ping
    while (!finished_ping.empty?)
      finished_ping.pop(true).save!
    end
    ######### save finishe pings into array or hash
    #render 
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

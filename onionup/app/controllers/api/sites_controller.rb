class Api::SitesController < ApplicationController
    # before_action :authenticate_user!

  def index
  @sites = Site.all

  @sites.each do |site|
    ping = Ping.new(site_id: site.id)
    if (site.ping)
      ping.status = true;
    else
      ping.status = false;
    end
    ping.save!  ######################### take out ! f
  end
  
    @pings = Ping.all
    # @sites = current_user.sites
    render json:[[@sites],[@pings]]
  end

  def show
    @site = Site.find_by(id: params[:id])
    render json:[@site]
  end

  def new
  end

  def create
    @site = Site.new(site_params)
    @site.user_id = current_user.id
    if @site.save
      render json: @site
    #  render "api/events/show"
    else
      render json: @site.errors.full_messages
      return
    end
    # fail
  end

  def destroy
    @site = Site.find_by(id: params[:id])
    if !@site
      redirect_to sites_url
      return
    elsif @site.destroy
      redirect_to sites_url
      return
    else
      flash.now[:errors] = @site.errors.full_messages
      return
    end
  end

  private

  def site_params
    params.require(:site).permit(:url)
  end
end

require 'thread'

class Api::SitesController < ApplicationController
  before_action :require_logged_in

  def show_ping
    @site = Site.find_by(id: params[:id])
    ping = Ping.new(site_id: @site.id)
    if (@site.ping)
        ping.status = true;
      else
        ping.status = false;
    end
    ping.save! ############################## remove
    '/api/sites/show.json.jbuilder'
  end

  def index_ping
    # get current users sites
    @sites = current_user.sites
    PingListJob.new.perform(@sites)
    render '/api/sites/index.json.jbuilder'
  end

  def index
    @sites = current_user.sites.includes(:pings);

  end

  def show
    @site = Site.find_by(id: params[:id])
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
      render
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

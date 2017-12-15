require 'thread'

class Api::SitesController < ApplicationController
  before_action :require_logged_in

  def show_ping
    @site = Site.find_by(id: params[:id])
    PingListJob.new.perform([@site])
    render '/api/sites/show.json.jbuilder'
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
    al = params[:site][:alias]
    if al.nil?
      @site.alias = ""
    else
      @site.alias = al
    end
    if @site.save
      # render json: @site
      render '/api/sites/show.json.jbuilder'
    else
      render json: @site.errors.full_messages
    end
  end

  def destroy
    @site = Site.find_by(id: params[:id])
    if !@site
      render json {["no such site"]}
    elsif @site.destroy
      render json {[success]}
    else
      flash.now[:errors] = @site.errors.full_messages
      render @site.errors.full_messages
    end
  end
  private

  def site_params
    params.require(:site).permit(:url)
  end
end

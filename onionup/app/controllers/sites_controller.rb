
class SitesController < ApplicationController

  before_action :authenticate_user!

  def index
    @sites = current_user.sites
  end

  def show
    @site = Site.find_by(id: params[:id])
  end

  def new
  end

  def create
    @site = Site.new(site_params)
    @site.user_id = current_user.id
    if @site.save
    redirect_to sites_url
      return
    else
      flash.now[:errors] = @site.errors.full_messages
      render :new
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

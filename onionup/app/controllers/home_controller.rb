class HomeController < ApplicationController
  def index
    redirect_to sites_url
  end
end

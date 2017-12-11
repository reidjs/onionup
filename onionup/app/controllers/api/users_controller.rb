
  class Api::UsersController < Devise::Controller
    prepend_before_action :require_no_authentication, :only => [:create ]
    include Devise::Controllers::InternalHelpers
    respond_to :json

    def create
      puts params
       build_resource
     resource = User.find_for_database_authentication(:login=>params[:user_login][:login])
     if resource.nil?
      render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    end
    end 


  end  


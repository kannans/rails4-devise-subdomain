class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include UrlHelper
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?  
  before_filter :check_path, if: :welcome_page?


  def check_path   
    redirect_to dashboard_url
  end 



  def after_sign_in_path_for(resource)    
    if !request.subdomain      
      root_url(:subdomain => current_user.subdomain) 
    elsif request.subdomain and current_user      
      dashboard_url
    else
      raise
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :subdomain, :email, :password, :password_confirmation) }
  end

  def welcome_page?
    params[:controller] == "welcome"
  end
end

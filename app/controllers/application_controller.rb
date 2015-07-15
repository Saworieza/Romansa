class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:avatar, :fullname, :sex, :lookingfor, :dateofbirth, :status, :city, :country, :bio, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:avatar, :fullname, :sex, :lookingfor, :dateofbirth, :status, :city, :country, :bio, :username, :email, :password, :password_confirmation, :current_password) }
  end

  before_filter :set_current_user

  #to fix the devise current signed in user issues
  def set_current_user
    Post.current_user = current_user
  end

  def track_activity(trackable, action = params[:action])
      current_user.activities.create! action: action, trackable: trackable 
  end
end

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  helper_method :mailbox, :conversation #conversation?
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def mailbox
    @mailbox ||= current_user.mailbox
  end

  #i think it should be conversation as it's a helper method, same as up there and also when installing the mailboxer it has sth called conversation generated
  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  
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
  hide_action :current_user


end

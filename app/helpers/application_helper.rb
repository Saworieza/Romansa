module ApplicationHelper
	#to add sign in to the home page
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  #to add sign in to the home page

end

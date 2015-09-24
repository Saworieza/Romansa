class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index]
  def index
  	#@users = User.all.order('created_at desc')
  	#this  line hee is awesome as it prevens me from kujiona on my onw page. but, it is hell as it throws and error if user aint sined in
  	@users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
  end
end

class UsersController < ApplicationController
  def index
  	#@users = User.all.order('created_at desc')
  	@users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def show
  end
end

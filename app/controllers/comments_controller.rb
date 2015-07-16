class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save
		
		if @comment.save
			#track_activity @comment
			redirect_to posts_path
		else
			render 'new'
		end
	end


	def edit
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def update
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if @comment.update(params[:comment].permit(:comment))
			#track_activity @comment 
			redirect_to posts_path
		else
			render 'edit'
		end
	end
	
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		track_activity @comment
		redirect_to posts_path
	end
end

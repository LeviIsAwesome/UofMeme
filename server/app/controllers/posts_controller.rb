class PostsController < ApplicationController
	def new
   		@post = Post.new
	end

	def index
		@posts = Post.all
	end
   
   	def show
   		@post = Post.find(params[:id])
   	end

	def create
	  	@post = Post.new(post_params)

	  	if @post.save
	     	redirect_to :action => 'index'
	  	else
	  		render "new"
	  	end
	end

	def like
		@post = Post.find(params[:id])
		@post.increment! :like
	end

	def dislike
		@post = Post.find(params[:id])
		@post.increment! :dislike
	end

	private

	def post_params
   		params.require(:post).permit(:poster, :image, :description)
	end
end
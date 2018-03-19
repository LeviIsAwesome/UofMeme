class PostsController < ApplicationController
	before_action :set_post, only: [:show, :update, :destroy]

	def new
   		@post = Post.new
   		json_response(@post)
	end

	def index
		@posts = Post.all
		json_response(@posts)
	end
   
   	def show
   		@post = Post.find(params[:post_id])
   		json_response(@post)
   	end

	def create
	  	@post = Post.new(post_params)
	  	json_response(@post, :created)

	  	if params[:post][:uploaded_image_for_io_adapters]
	      content_type = Mime::Type.lookup_by_extension(File.extname(params[:post][:file_name])[1..-1]).to_s
	      image_file = Paperclip.io_adapters.for("data:#{content_type};base64,#{params[:post][:uploaded_image_for_io_adapters]}")
	      image_file.original_filename = params[:post][:file_name]
	      @post.image = image_file
	    end

	  	if @post.save
	  		flash[:info] = "Meme successfully created"
	     	redirect_to root_url
	  	else
	  		flash[:info] = "There was an error. Your Meme wasn't created"
	  		render "new"
	  	end
	end

	# PATCH/PUT /posts/1
	# PATCH/PUT /posts/1.json
	def update
		@post.update(post_params)
		head :no_content		
	end

	# DELETE /posts/1
	# DELETE /posts/1.json
	def destroy
		@post.destroy
		head :no_content
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.permit(:poster, :description, :user_id, :file_name, :image, :uploaded_image_for_io_adapters)
	end
end

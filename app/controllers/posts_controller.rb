class PostsController < ApplicationController
	before_action :is_logged_in?, except: [:index]

  def index
  	@posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params) 
  	@post.user_id = current_user.id
  	if @post.save
  		redirect_to posts_path
  	else
  		render :new
  	end
  end

  private

  def post_params
  	params.require(:post).permit(:title, :content)
  end

  private
  
  def is_logged_in?
  	redirect_to root_path if !current_user
  end 
end

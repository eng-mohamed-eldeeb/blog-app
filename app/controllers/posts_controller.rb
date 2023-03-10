class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 3)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes(:comments).find_by_id(params[:id])
    @like = Like.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path notice: 'Post created successfully'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

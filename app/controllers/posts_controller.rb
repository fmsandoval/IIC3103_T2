class PostsController < ApplicationController
  before_action :check_admin, except: [:index, :show]
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  def index
    #@posts = Post.all
    @posts = Post.order(created_at: :desc).limit(10)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to '/posts/admin'
    else
      render 'new'
    end
  end

  def show
    @comment = @post.comments.build
  end

  def update
    if @post.update(post_params)
      redirect_to '/posts/admin'
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to '/posts/admin'
  end

  def admin
    @posts = Post.all.order(created_at: :desc)
  end

  private
  def post_params
    params.require(:post).permit(:title, :lead, :body)
  end

  def check_admin
    if !admin_signed_in?
      redirect_to posts_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

end

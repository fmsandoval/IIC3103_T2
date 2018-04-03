class Api::V1::NewsController < ApplicationController
  skip_before_action  :verify_authenticity_token

  def index
    @posts = Post.all
    render json: @posts.to_json, status: 200

  end

  def show
    @post = Post.find_by_id(params[:id])
    if !@post.nil?
      render json: @post, status: 200
    else
      render json: {error: 'not found'}, status: 404
    end
  end

  def create
    if !check_params_create
      render json: { error: 'params error' }, status: 400
    else
      if params[:subtitle].present?
        @post = Post.new(title: params[:title], lead: params[:subtitle], body: params[:body])
      else
        @post = Post.new(title: params[:title], lead: 'no subtitle', body: params[:body])
      end
      if @post.save
        render json: @post.to_json, status: 201
      else
        render json: { error: 'not created' }, status: 400
      end
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      if !check_params_update
        render json: { error: 'not updated' }, status: 400
      else
        if @post.update_attributes(update_new_params)
          render json: @post.to_json, status: 200
        else
          render json: { error: 'not updated' }, status: 400
        end
      end
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      @post.delete
      render json: { success: 'success' }, status: 200
    end
  end

  def comment_index
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      @comments = @post.comments
      render json: @comments.to_json, status: 200
    end
  end

  def comment_create
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      if !check_params_create_comment
        render json: { error: 'params error' }, status: 400
      else
        @comment = @post.comments.new(commenter: params[:author], body: params[:comment])
        if @comment.save
          render json: @comment.to_json, status: 201
        else
          render json: { error: 'not created' }, status: 400
        end
      end
    end
  end

  private
  def create_new_params
    params.permit(:title, :subtitle, :body)
  end

  def update_new_params
    params.permit(:title, :subtitle, :body)
  end

  def check_params_create
    permitted = create_new_params
    !(permitted[:title].nil? && permitted[:body].nil?)
  end

  def check_params_update
    permitted = update_new_params
    !(permitted[:title].nil? && permitted[:subtitle].nil? && permitted[:body].nil?)
  end

  def create_new_comment_params
    params.permit(:author, :comment)
  end

  def check_params_create_comment
    permitted = create_new_comment_params
    !(permitted[:author].nil? && permitted[:comment].nil?)
  end

end

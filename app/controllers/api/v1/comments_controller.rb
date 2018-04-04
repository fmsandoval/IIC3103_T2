class Api::V1::CommentsController < ApplicationController
  skip_before_action  :verify_authenticity_token

  def index
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      @comments = @post.comments
      render json: @comments.to_json, status: 200
    end
  end

  def show
    @post = Post.find_by_id(params[:news_id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      @comment = Comment.find_by_id(params[:id])
      if @comment.nil?
        render json: { error: 'not found' }, status: 404
      elsif @post.comments.include?(@comment)
        render json: @comment.to_json, status: 200
      else
        render json: { error: 'comment belongs to other new' }, status: 400
      end
    end
  end

  def create
    @post = Post.find_by_id(params[:id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      if !check_params_create
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

  def update
    @post = Post.find_by_id(params[:news_id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      @comment = Comment.find_by_id(params[:id])
      if @comment.nil?
        render json: { error: 'not found' }, status: 404
      else
        if !@post.comments.include?(@comment)
          render json: { error: 'comment belongs to other new' }, status: 400
        elsif !check_params_update
          render json: { error: 'not updated' }, status: 400
        else
          if @comment.update_attributes(update_comment_params)
            render json: @comment.to_json, status: 200
          else
            render json: { error: 'not updated' }, status: 400
          end
        end
      end
    end
  end

  def destroy
    @post = Post.find_by_id(params[:news_id])
    if @post.nil?
      render json: { error: 'not found' }, status: 404
    else
      @comment = Comment.find_by_id(params[:id])
      if @comment.nil?
        render json: { error: 'not found' }, status: 404
      elsif @post.comments.include?(@comment)
        @comment.delete
        render json: { success: 'success' }, status: 200
      else
        render json: { error: 'comment belongs to other new' }, status: 400
      end
    end
  end


  private
  def create_comment_params
    params.permit(:author, :comment)
  end

  def update_comment_params
    params.permit(:author, :comment)
  end

  def check_params_create
    permitted = create_comment_params
    !(permitted[:author].nil? && permitted[:comment].nil?)
  end

  def check_params_update
    permitted = update_comment_params
    !(permitted[:author].nil? && permitted[:comment].nil?)
  end

end

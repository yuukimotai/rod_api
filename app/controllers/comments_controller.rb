class CommentsController < ApplicationController
  before_action :set_post, :set_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @user = current_user
    @comments = Comment.where(user_uuid: current_user.uuid)
                       .order(updated_at: :desc).limit(100)
    render json: @comments
  end

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  # POST /comments
  def create
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.user_uuid = @user.uuid
    @comment.user = @user
    @comment.post = @post

    if comment_params[:post_id].present?
      @comment.post_id = comment_params[:post_id]
    else
      @comment.parent_id = comment_params[:parent_id]
    end

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end
    
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:uuid, :title, :content, :parent_id, :user_id, :post_id)
    end
end

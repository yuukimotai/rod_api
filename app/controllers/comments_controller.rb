class CommentsController < ApplicationController
  before_action :set_idea, only: %i[ index show create update destroy ]

  # GET /comments
  def index
    @user = current_user# current_userのチェック必要

    @comments = Comment.where(idea_id: @idea.id)
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
    @comment.uuid = @user.uuid
    @comment.user = @user
    @comment.idea = @idea

    if comment_params[:idea_id].present?
      @comment.parent_id = comment_params[:parent_id]
    else
      @comment.idea_id = @idea.id
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
    def set_idea
      @idea = Idea.find_by(id: params[:idea_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:uuid, :title, :content, :parent_id, :user_id, :post_id)
    end
end

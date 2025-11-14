class MyCommentsController < ApplicationController
  before_action :set_comment, only: %i[ update destroy ]

  def index
    @user = current_user# current_userのチェック必要
    @comments = Comment.where(uuid: @user.uuid)

    render json: @comments
  end

  def update
    @user = current_user

    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      print(params[:idea_id])
      @idea = Idea.find_by(id: params[:idea_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:my_comment).permit( :id, :content, :emotions)
    end
end

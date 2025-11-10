class IdeasController < ApplicationController
  before_action :set_idea, only: %i[ show update destroy ]
  # GET /ideas
  def index
    @user = current_user
    @ideas = Idea.where(uuid: current_user.uuid)
                 .order(updated_at: :desc).limit(100)

    render json: @ideas
  end

  # GET /ideas/1
  def show
    render json: @idea
  end

  # idea /ideas
  def create
    @user = current_user
    @idea = Idea.new(idea_params)
    @idea.uuid = @user.uuid
    @idea.user = @user

    if @idea.save
      render json: @idea, status: :created, location: @idea
    else
      render json: @idea.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ideas/1
  def update
    @user = current_user
    if @idea.update(idea_params)
      render json: @idea
    else
      render json: @idea.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ideas/1
  def destroy
    @idea.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_params
      params.require(:idea).permit(:user_id, :uuid, :title, :content, :priority_emoji, :is_public)
    end
end

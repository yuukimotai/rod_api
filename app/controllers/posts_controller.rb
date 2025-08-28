class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @user = current_user  
    existing_posts = @user.posts.maximum(:post_number) || 0
    newest_post_number = existing_posts + 1

    # Use the association to build the new post
    @post = @user.posts.build(post_params.merge(uuid: @user.uuid, post_number: newest_post_number))

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @user = current_user
      @post = @user.posts.find_by(post_number: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:uuid, :title, :content, :priority_emoji, :user_id)
    end
end

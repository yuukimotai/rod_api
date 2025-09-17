class SearchpostsController < ApplicationController
    def search_by_content
        @posts = Post.search_by_content(params[:word])
        render json: @posts
    end
    def search_by_username
        @posts = Post.search_by_username(params[:word])
        render json: @posts
    end
end

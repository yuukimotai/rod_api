module Shared
    class IdeasController < ApplicationController
        before_action :authenticate
        before_action :set_idea, only: %i[ show ]

        def index
            @ideas = Idea.where(is_public: true)
                         .order(updated_at: :desc).limit(100)
        
            render json: @ideas
        end
        
        # GET /ideas/1
        def show
            render json: @idea
        end
        private
        def set_idea
            @idea = Idea.find(params[:id])
        end
    end
end
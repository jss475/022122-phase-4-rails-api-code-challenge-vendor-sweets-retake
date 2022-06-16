class SweetsController < ApplicationController
    def index
        render json: Sweet.all, status: :ok
    end

    def show
        show = Sweet.find_by_id(params[:id])
        if show
            render json: show, status: :ok
        else
            render json: {error: "Sweet not found"}, status: :not_found
        end
    end
end

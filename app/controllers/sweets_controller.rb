class SweetsController < ApplicationController
    def index
        render json: Sweet.all, status: :ok
    end

    def show
        sweet = Sweet.find_by(id: params[:id])
        if sweet
            render json: sweet, status: :ok
        else
            render json: {error: "Sweet not found"}, status: :not_found
        end
    end
end

class VendorSweetsController < ApplicationController

    def create
        vs = VendorSweet.create(vs_params)
        if vs.valid?
            render json: vs, status: :created
        else
            render json: {errors: ["validation errors"]}, status: :unprocessable_entity
        end
    end

    def destroy
        vs = VendorSweet.find_by(id: params[:id])
        if vs
            vs.destroy
            render json: {}, status: :ok
        else
            render json: {error: "VendorSweet not found"}, status: :not_found
        end
    end

    private

    def vs_params
        params.permit(:price, :vendor_id, :sweet_id)
    end

end

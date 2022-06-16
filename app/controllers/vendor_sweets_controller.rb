class VendorSweetsController < ApplicationController
    def create
        vendorsweet = VendorSweet.create!(vendorsweet_params)
        if vendorsweet.valid?
            render json: vendorsweet, status: :created, serializer: CreateVendorSweetSerializer
        else
            render json: {errors: ["validation errors"] }, status: 422
        end
    end

    def destroy
        vendorsweet = VendorSweet.find_by_id(params[:id])
        if vendorsweet
            vendorsweet.destroy
            render json: {}
        else
            render json: {error: "VendorSweet not found"}, status: :not_found
        end
    end

    private

    def vendorsweet_params
        params.permit(:price, :vendor_id, :sweet_id)
    end
end

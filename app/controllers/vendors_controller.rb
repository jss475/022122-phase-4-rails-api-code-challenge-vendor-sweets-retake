class VendorsController < ApplicationController
    
    def index
        render json: Vendor.all, status: :ok
    end

    def show
        vendor = Vendor.find_by(id: params[:id])
        if vendor
            render json: vendor, status: :ok, serializer: IndividualVendorSerializer
        else
            render json: {error: "Vendor not found"}, status: :not_found
        end
    end

end

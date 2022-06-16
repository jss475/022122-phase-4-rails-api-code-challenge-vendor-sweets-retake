class VendorSweetSerializer < ActiveModel::Serializer
    belongs_to :sweet
    belongs_to :vendor
    attributes :id, :name, :price

    def name
        object.sweet.name
    end
end
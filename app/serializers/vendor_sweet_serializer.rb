class VendorSweetSerializer < ActiveModel::Serializer
  attributes :id, :name, :price

  def name
    object.sweet.name
  end
end

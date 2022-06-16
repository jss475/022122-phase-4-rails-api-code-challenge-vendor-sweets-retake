class VendorSweet < ApplicationRecord
    belongs_to :sweet
    belongs_to :vendor

    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
end

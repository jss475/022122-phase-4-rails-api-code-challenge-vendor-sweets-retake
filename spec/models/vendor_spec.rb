require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'relationships' do
    before do
      vendor = Vendor.create(name: 'Insomnia Cookies')
      sweet = Sweet.create(name: 'Chocolate Chip Cookie')
      VendorSweet.create(vendor_id: vendor.id, sweet_id: sweet.id, price: 300)
    end

    let(:sweet) { Sweet.first }
    let(:vendor) { Vendor.first }
    let(:vendor_sweet) { VendorSweet.first }

    it 'can access the associated vendor_sweets' do
      expect(vendor.vendor_sweets).to include(vendor_sweet)
    end

    it 'can access the associated sweets' do
      expect(vendor.sweets).to include(sweet)
    end
  end
end

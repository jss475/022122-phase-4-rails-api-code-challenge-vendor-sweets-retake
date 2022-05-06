require 'rails_helper'

RSpec.describe VendorSweet, type: :model do
  before do
    vendor = Vendor.create(name: 'Insomnia Cookies')
    sweet = Sweet.create(name: 'Chocolate Chip Cookie')
    VendorSweet.create(vendor_id: vendor.id, sweet_id: sweet.id, price: 300)
  end

  let(:sweet) { Sweet.first }
  let(:vendor) { Vendor.first }
  let(:vendor_sweet) { VendorSweet.first }

  describe 'relationships' do
    it 'can access the associated vendor' do
      expect(vendor_sweet.vendor).to eq(vendor)
    end

    it 'can access the associated sweet' do
      expect(vendor_sweet.sweet).to eq(sweet)
    end
  end

  describe 'validations' do
    it 'is valid when price is present and a positive number' do
      vs =
        VendorSweet.create(vendor_id: vendor.id, sweet_id: sweet.id, price: 300)
      expect(vs).to be_valid
    end

    it 'is invalid when price is not present' do
      vs = VendorSweet.create(vendor_id: vendor.id, sweet_id: sweet.id)
      expect(vs).to be_invalid
    end

    it 'is invalid when price is a negative number' do
      vs =
        VendorSweet.create(
          vendor_id: vendor.id,
          sweet_id: sweet.id,
          price: -100,
        )
      expect(vs).to be_invalid
    end
  end
end

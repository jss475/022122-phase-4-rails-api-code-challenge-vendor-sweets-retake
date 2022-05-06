require 'rails_helper'

RSpec.describe 'Sweets', type: :request do
  before do
    v1 = Vendor.create(name: 'Insomnia Cookies')
    v2 = Vendor.create(name: 'Tribeca Treats')
    s1 = Sweet.create(name: 'Chocolate Chip Cookie')
    s2 = Sweet.create(name: 'Brownie')
    VendorSweet.create(vendor_id: v1.id, sweet_id: s1.id, price: 300)
    VendorSweet.create(vendor_id: v1.id, sweet_id: s2.id, price: 200)
    VendorSweet.create(vendor_id: v2.id, sweet_id: s2.id, price: 350)
  end

  describe 'GET /sweets' do
    it 'returns an array of all sweets' do
      get '/sweets'

      expect(response.body).to include_json(
        [
          { id: a_kind_of(Integer), name: 'Chocolate Chip Cookie' },
          { id: a_kind_of(Integer), name: 'Brownie' },
        ],
      )
    end

    it 'returns a status of 200 (OK)' do
      get '/sweets'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /sweets/:id' do
    context 'with a valid ID' do
      it 'returns the matching sweet' do
        get "/sweets/#{Sweet.first.id}"

        expect(response.body).to include_json(
          { id: a_kind_of(Integer), name: 'Chocolate Chip Cookie' },
        )
      end

      it 'returns a status of 200 (OK)' do
        get "/sweets/#{Sweet.first.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid ID' do
      it 'returns an error message' do
        get '/sweets/bad_id'
        expect(response.body).to include_json({ error: 'Sweet not found' })
      end

      it 'returns the appropriate HTTP status code' do
        get '/sweets/bad_id'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

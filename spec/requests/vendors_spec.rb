require 'rails_helper'

RSpec.describe 'Vendors', type: :request do
  before do
    v1 = Vendor.create(name: 'Insomnia Cookies')
    v2 = Vendor.create(name: 'Tribeca Treats')
    s1 = Sweet.create(name: 'Chocolate Chip Cookie')
    s2 = Sweet.create(name: 'Brownie')
    VendorSweet.create(vendor_id: v1.id, sweet_id: s1.id, price: 300)
    VendorSweet.create(vendor_id: v1.id, sweet_id: s2.id, price: 200)
    VendorSweet.create(vendor_id: v2.id, sweet_id: s2.id, price: 350)
  end

  describe 'GET /vendors' do
    it 'returns an array of all vendors' do
      get '/vendors'

      expect(response.body).to include_json(
        [
          { id: a_kind_of(Integer), name: 'Insomnia Cookies' },
          { id: a_kind_of(Integer), name: 'Tribeca Treats' },
        ],
      )
    end

    it 'returns a status of 200 (OK)' do
      get '/vendors'

      expect(response).to have_http_status(:ok)
    end

    it 'does not return any nested vendor_sweets' do
      get '/vendors'

      expect(response.body).not_to include_json(
        [{ vendor_sweets: a_kind_of(Array) }],
      )
    end
  end

  describe 'GET /vendors/:id' do
    context 'with a valid ID' do
      it 'returns the matching vendor with its associated vendor_sweets' do
        get "/vendors/#{Vendor.first.id}"

        expect(response.body).to include_json(
          {
            id: a_kind_of(Integer),
            name: 'Insomnia Cookies',
            vendor_sweets: [
              {
                id: a_kind_of(Integer),
                name: 'Chocolate Chip Cookie',
                price: 300,
              },
              { id: a_kind_of(Integer), name: 'Brownie', price: 200 },
            ],
          },
        )
      end

      it 'returns a status of 200 (OK)' do
        get "/vendors/#{Vendor.first.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid ID' do
      it 'returns an error message' do
        get '/vendors/bad_id'
        expect(response.body).to include_json({ error: 'Vendor not found' })
      end

      it 'returns the appropriate HTTP status code' do
        get '/vendors/bad_id'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'VendorSweets', type: :request do
  before do
    v1 = Vendor.create(name: 'Insomnia Cookies')
    v2 = Vendor.create(name: 'Tribeca Treats')
    s1 = Sweet.create(name: 'Chocolate Chip Cookie')
    s2 = Sweet.create(name: 'Brownie')
    VendorSweet.create(vendor_id: v1.id, sweet_id: s1.id, price: 300)
    VendorSweet.create(vendor_id: v1.id, sweet_id: s2.id, price: 200)
    VendorSweet.create(vendor_id: v2.id, sweet_id: s2.id, price: 350)
  end

  describe 'POST /vendor_sweets' do
    context 'with valid data' do
      let!(:vendor_sweet_params) do
        { vendor_id: Vendor.last.id, sweet_id: Sweet.first.id, price: 300 }
      end

      it 'creates a new VendorSweet' do
        expect { post '/vendor_sweets', params: vendor_sweet_params }.to change(
          VendorSweet,
          :count,
        ).by(1)
      end

      it 'returns the correct data' do
        post '/vendor_sweets', params: vendor_sweet_params

        expect(response.body).to include_json(
          { id: a_kind_of(Integer), name: 'Chocolate Chip Cookie', price: 300 },
        )
      end

      it 'returns a status code of 201 (created)' do
        post '/vendor_sweets', params: vendor_sweet_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid data' do
      let(:invalid_params) do
        { vendor_id: Vendor.last.id, sweet_id: Sweet.first.id }
      end

      it 'does not create a new VendorSweet' do
        expect { post '/vendor_sweets', params: invalid_params }.to change(
          VendorSweet,
          :count,
        ).by(0)
      end

      it 'returns the error messages as an array' do
        post '/vendor_sweets', params: invalid_params

        expect(response.body).to include_json({ errors: a_kind_of(Array) })
      end

      it 'returns a status code of 422 (Unprocessable Entity)' do
        post '/vendor_sweets', params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /vendor_sweet/:id' do
    context 'with a valid ID' do
      it 'deletes the vendor_sweet' do
        delete "/vendor_sweets/#{VendorSweet.first.id}"

        expect(response.body).to include_json({})
      end
    end

    context 'with an invalid ID' do
      it 'returns an error message' do
        delete '/vendor_sweets/bad_id'

        expect(response.body).to include_json(
          { error: 'VendorSweet not found' },
        )
      end

      it 'does not delete any VendorSweet' do
        expect { delete '/vendor_sweets/bad_id' }.to change(VendorSweet, :count)
          .by(0)
      end

      it 'returns the appropriate HTTP status code' do
        delete '/vendor_sweets/bad_id'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

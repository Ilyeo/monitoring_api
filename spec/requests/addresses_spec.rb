require 'rails_helper'

RSpec.describe Api::AddressesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:addresses) { create_list(:address, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:address_id) { addresses.first.id }

  # Test suite for GET /api/users/:user_id/addresses
  describe 'GET /api/users/:user_id/addresses' do
    # make HTTP get request before each example
    before { get :index, params: { user_id: user.id } }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user addresses' do
        expect(JSON.parse(response.body).count).to eq(20)
      end
    end

    context 'when user does not exists' do
      before { get :index, params: { user_id: 0 } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User with 'id'=0/)
      end
    end

  end

  # Test suite for GET /api/users/:user_id/addresses/:id
  describe 'GET /api/users/:user_id/addresses/:id' do
    before { get :show, params: { user_id: user.id, id: addresses.first.id } }

    context 'when user address exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the address' do
        expect(JSON.parse(response.body)['id']).to eq(addresses.first.id)
      end
    end

    context 'when user address does not exist' do
      before { get :show, params: { user_id: user.id, id: 0 } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Address/)
      end
    end
  end

  # Test suite for POST /api/users/:user_id/addresses
  describe 'POST /api/users/:users_id/addresses' do

    context 'when request attributes are valid' do
      before { post :create, params: { user_id: user.id, street: 'Mateo Almanza 341', zip_code: '20126', state: 'Aguascalientes', country: 'Mexico', city: 'Aguascalientes' } }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post :create, params: { user_id: user.id, street: 'Mateo Almanza 341', zip_code: '', state: 'Aguascalientes', country: 'Mexico', city: 'Aguascalientes' } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message for zip code' do
        expect(response.body).to match(/Validation failed: Zip code can't be blank/)
      end

    end
  end

  # Test suite for PUT /api/users/:user_id/addresses
  describe 'PUT /api/users/:users_id/addresses' do
    context 'when address exist' do
      before { put :update, params: { user_id: user.id, id: addresses.first.id, street: 'Av. Constitucion' } }
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'update the address' do
        updated_item = Address.find(address_id)
        expect(updated_item.street).to match(/Av. Constitucion/)
      end
    end

    context 'when the address does not exist' do
      before { put :update, params: { user_id: user.id, id: 0 } }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Address/)
      end
    end
  end

  # Test suite for DELETE /api/users/:user_id/addresses
  describe 'DELETE /api/users/:user_id/addresses/:id' do
    before { delete :destroy, params: { user_id: user.id, id: addresses.first.id } }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end


end

require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:address) { create(:address, user_id: user.id) }
  let!(:events) { create_list(:event, 20, address_id: address.id) }
  let(:user_id) { user.id }
  let(:address_id) { address.id }
  let(:event_id) { events.first.id }

  # Test suite for GET /api/users/:user_id/addresses/:address_id/events
  describe 'GET /api/users/:user_id/addresses/:address_id/events' do
    # make HTTP get request before each example
    before { get :index, params: { user_id: user.id, address_id: address.id, id: events.first.id } }

    context 'when address exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all address events' do
        expect(JSON.parse(response.body).count).to eq(20)
      end
    end

    context 'when address does not exists' do
      before { get :index, params: { user_id: user.id, address_id: 0, id: events.first.id } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Address with 'id'=0/)
      end
    end
  end

  # Test suite for GET /api/users/:user_id/addresses/:address_id/events/:id'
  describe 'GET /api/users/:user_id/addresses/:address_id/events/:id' do
    before { get :show, params: { user_id: user.id, address_id: address.id, id: events.first.id } }

    context 'when address event exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the event' do
        expect(JSON.parse(response.body)['id']).to eq(events.first.id)
      end
    end

    context 'when user address does not exist' do
      before { get :show, params: { user_id: user.id, address_id: address.id, id: 0 } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  # Test suite for GET /api/users/:user_id/addresses/:address_id/events'
  describe 'POST /api/users/:users_id/addresses/:address_id/events' do

    context 'when request attributes are valid' do
      before { post :create, params: { user_id: user.id, address_id: address.id, zone_code: 07, zone_description: 'Main door', event_type: 'Fuego' } }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post :create, params: { user_id: user.id, address_id: address.id } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Zone code can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/users/:user_id/addresses/:address_id/events/:id
  describe '/api/users/:user_id/addresses/:address_id/events/:id' do
    before { put :update, params: { user_id: user.id, address_id: address.id, id: events.first.id, zone_description: 'Living room' } }

    context 'when event exist' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'update the event' do
        updated_item = Event.find(event_id)
        expect(updated_item.zone_description).to match(/Living room/)
      end
    end

    context 'when the event does not exist' do
      before { put :update, params: { user_id: user.id, address_id: address.id, id: 0, zone_description: 'Living room' } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  # Test suite for DELETE /api/users/:user_id/addresses/:address_id/events/:id
  describe 'DELETE /api/users/:user_id/addresses/:address_id/events/:id' do
    before { delete :destroy, params: { user_id: user.id, address_id: address.id, id: events.first.id } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

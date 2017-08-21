require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  let!(:user) { create(:user) }
  let!(:address) { create(:address, user_id: user.id) }
  let!(:events) { create_list(:event, 20, address_id: address.id) }
  let(:user_id) { user.id }
  let(:address_id) { address.id }
  let(:event_id) { events.first.id }

  # Test suite for GET /api/users/:user_id/addresses/:address_id/events
  describe 'GET /api/users/:user_id/addresses/:address_id/events' do
    # make HTTP get request before each example
    before { get "/api/users/#{user_id}/addresses/#{address_id}/events" }

    context 'when address exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all address events' do
        expect(json.size).to eq(20)
      end
    end

    context 'when address does not exists' do
      let(:address_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Address with 'id'=0/)
      end
    end
  end

end

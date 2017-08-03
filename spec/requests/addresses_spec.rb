require 'rails_helper'

RSpec.describe 'Addresses API', type: :request do
  let!(:user) { create(:user) }
  let!(:addresses) { create_list(:address, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { addresses.first.id }

  # Test suite for GET /api/users/:user_id/addresses
  describe 'GET /api/users/:user_id/addresses' do
    # make HTTP get request before each example
    before { get "/api/users/#{user_id}/addresses" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user addresses' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exists' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User with 'id'=0/)
      end
    end

  end
end

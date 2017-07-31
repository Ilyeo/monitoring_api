require 'rails_helper'

RSpec.describe 'Users API', type: :request do

  let!(:users) { create_list(:user, 10) }

  describe 'GET /api/users' do
    # make HTTP get request before each example
    before { get '/api/users' }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end

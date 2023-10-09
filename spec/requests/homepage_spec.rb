require 'rails_helper'

RSpec.describe "Homepages", type: :request do
  describe "GET via homepage" do
    it 'success GET /' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'success GET history' do
      get '/homepage/history'
      expect(response).to have_http_status(:success)
    end

    it 'success GET teachers' do
      get '/homepage/teachers'
      expect(response).to have_http_status(:success)
    end

    it 'success GET museum' do
      get '/homepage/museum'
      expect(response).to have_http_status(:success)
    end

    it 'success GET materials' do
      get '/homepage/materials'
      expect(response).to have_http_status(:success)
    end
  end
end

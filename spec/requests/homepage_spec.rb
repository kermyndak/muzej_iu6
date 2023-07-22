require 'rails_helper'

RSpec.describe "Homepages", type: :request do
  describe "GET /" do
    it 'return http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end

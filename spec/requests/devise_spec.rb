require 'rails_helper'

RSpec.describe "Devises controllers", type: :request do
  describe "GET users/sign_up" do
    it 'return http success' do
      get new_user_registration_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET users/sign_in" do
    it 'return http success' do
      get new_user_session_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST users/sign_in" do
    before do
      User.create(
        email: "tester@test.ru", password: "password", 
        password_confirmation: 'password', name: 'Tester', 
        surname: "Tester_surname", middle_name: "Tester_middle_name", 
        year: 2000, confirmed_at: '2023-07-21 10:25:15.076243'
      )
    end
    it 'return http redirected' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      expect(response).to have_http_status(303)
    end
  end

  # describe "DELETE users/sign_out" do
  #   before do
  #     User.create(email: "tester@test.ru", password: "password", name: 'Tester', surname: "Tester_surname", middle_name: "Tester_middle_name", year: 2000, confirmed_at: '2023-07-21 10:25:15.076243')
  #     post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
  #   end
  #   it 'return http unprocessable entity' do
  #     delete destroy_user_session_url, params: {_method: 'delete'}
  #     expect(response).to have_http_status(422)
  #   end
  # end
end
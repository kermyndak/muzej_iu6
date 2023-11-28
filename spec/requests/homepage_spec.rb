require 'rails_helper'

RSpec.describe "Homepages", type: :request do
  before do
    @admin_user = User.create(
      email: "tester@admin.ru", password: "password", 
      password_confirmation: 'password', name: 'Tester_admin', 
      surname: "Tester_surname", middle_name: "Tester_middle_name", 
      year: 2000, confirmed_at: '2023-07-21 10:25:15.076243', role: 'admin'
    )

    @user = User.create(email: "tester@test.ru", password: "password", 
      password_confirmation: 'password', name: 'Tester', 
      surname: "Tester_surname", middle_name: "Tester_middle_name", 
      year: 2000, confirmed_at: '2023-07-21 10:25:15.076243'
    )
  end

  describe "GET via homepage" do
    it 'success GET /' do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it 'success GET history' do
      get history_url
      expect(response).to have_http_status(:success)
    end

    it 'success GET teachers' do
      get teachers_url
      expect(response).to have_http_status(:success)
    end

    it 'success GET museum' do
      get museum_url
      expect(response).to have_http_status(:success)
    end

    it 'success GET materials' do
      get materials_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET on profile list' do
    it 'GET profile_list redirect if guest on root path' do
      get '/homepage/profile_list'
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET exit_profile_list redirect if guest on root path' do
      get '/homepage/exit_profile_list'
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'GET profile_list success if default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get '/homepage/profile_list'
      expect(response).to have_http_status(:success)
    end

    it 'GET profile_list success if admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get '/homepage/profile_list'
      expect(response).to have_http_status(:success)
    end

    it 'GET exit_profile_list if default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get '/homepage/exit_profile_list'
      expect(response).to have_http_status(:success)
    end

    it 'GET exit_profile_list if admin' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get '/homepage/exit_profile_list'
      expect(response).to have_http_status(:success)
    end
  end
end

require 'rails_helper'

RSpec.describe "Profiles", type: :request do
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

  describe "GET profile/admin_profile" do
    it 'redirect to sign_in' do
      get profile_admin_profile_url
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'return http status success' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get profile_admin_profile_url
      expect(response).to have_http_status(:success)
    end

    it 'redirect to root_path if default user log in' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get profile_admin_profile_url
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET profile/profile" do
    it 'redirect to sign_in' do
      get profile_profile_url
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'return http status success' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get profile_profile_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT profile/set_admin" do
    it 'redirect to sign_in' do
      put '/profile/set_admin/99'
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'redirect to root_path if default user log in' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      put '/profile/set_admin/99'
      expect(response).to redirect_to(root_path)
    end

    it 'success when admin log in' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      put "/profile/set_admin/#{@user.id}", xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET profile/edit" do
    it 'redirect to sign_in' do
      get '/profile/edit/0'
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'return http status success' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get "/profile/edit/#{@user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'redirect to root_path if default user log in' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get '/profile/edit/99'
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET profile/change" do
    it 'redirect to sign_in' do
      get '/profile/change/0'
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'return http status success' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get "/profile/change/#{@user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'check error on update other user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get "/profile/change/#{@admin_user.id}"
      expect(response).to redirect_to(root_path)
    end

    it 'check not error on update other user from admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get "/profile/change/#{@user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT profile/update" do
    it 'redirect to sign_in' do
      put '/profile/update/name/0'
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'check error on update other user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      put "/profile/update/name/0"
      expect(response).to redirect_to(root_path)
    end

    it 'check not error on update other user from admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      put "/profile/update/name/#{@user.id}", xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST profile/destroy" do
    it 'redirect to sign_in' do
      post '/profile/destroy/0'
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'return http status success' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      post "/profile/destroy/#{@user.id}", xhr: true
      expect(response).to have_http_status(:success)
    end

    it 'not redirect to root_path if default user log in and request with other user parameter' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      post '/profile/destroy/99', xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST profile/cancel_destroy" do
    it 'redirect to sign_in' do
      post '/profile/cancel_destroy/0'
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'return http status success' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      post "/profile/cancel_destroy/#{@user.id}", xhr: true
      expect(response).to have_http_status(:success)
    end

    it 'not redirect to root_path if default user log in and request with other user parameter' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      post '/profile/cancel_destroy/99', xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE profile/confirm_destroy" do
    it 'redirect to sign_in' do
      delete '/profile/confirm_destroy/0'
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'delete user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      delete "/profile/confirm_destroy/#{@user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'check error on delete other user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      delete "/profile/confirm_destroy/0"
      expect(response).to redirect_to(root_path)
    end

    it 'check not error on delete other user from admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      delete "/profile/confirm_destroy/#{@user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end

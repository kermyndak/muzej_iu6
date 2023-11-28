require 'rails_helper'

RSpec.describe "Requests", type: :request do
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

    @request_with_message = Request.create(message: 'some message', user_id: @user.id)
  end

  describe "GET add_files" do
    it 'redirected GET for default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get add_files_url
      expect(response).to redirect_to(root_path)
    end

    it 'success GET for admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get add_files_url
      expect(response).to have_http_status(:success)
    end

    it 'redirected for non auth' do
      get add_files_url
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET send_files" do
    it 'success GET for default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get send_request_url
      expect(response).to have_http_status(:success)
    end

    it 'success GET for admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get send_request_url
      expect(response).to have_http_status(:success)
    end

    it 'redirected for non auth' do
      get send_request_url
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET admin' do
    it 'redirect for default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get requests_url
      expect(response).to redirect_to(root_path)
    end

    it 'redirect for guest' do
      get requests_url
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'success for admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get requests_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET already_read' do
    it 'redirect for default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get already_read_url
      expect(response).to redirect_to(root_path)
    end

    it 'redirect for guest' do
      get already_read_url
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'success for admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get already_read_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST read' do
    it 'redirect for guest' do
      post "/request/read/#{@request_with_message.id}"
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirect for default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      post "/request/read/#{@request_with_message.id}"
      expect(response).to redirect_to(root_path)
    end

    it 'check read field in request without read' do
      r = Request.find(@request_with_message.id)
      expect(r.read).to be false
    end

    it 'check read field in request' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      post "/request/read/#{@request_with_message.id}"
      r = Request.find(@request_with_message.id)
      expect(r.read).to be true
    end

    it 'success for admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      post "/request/read/#{@request_with_message.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    it 'redirect if guest' do
      post request_create_url, params: {message: 'some message'}
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'success if default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      post request_create_url, params: {message: 'some message'}
      expect(response).to have_http_status(204)
    end

    it 'success if admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      post request_create_url, params: {message: 'some message'}
      expect(response).to have_http_status(204)
    end
  end

  describe 'GET add_files' do
    it 'redirect if guest' do
      get add_files_url
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirect if default user' do
      post user_session_url, params: {user: {email: "tester@test.ru", password: "password", remember_me: 0}}
      get add_files_url
      expect(response).to redirect_to(root_path)
    end

    it 'success if admin' do
      post user_session_url, params: {user: {email: "tester@admin.ru", password: "password", remember_me: 0}}
      get add_files_url
      expect(response).to have_http_status(:success)
    end
  end
end

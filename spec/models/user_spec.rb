require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'If adding with similar params' do
    before do
      User.create!(
        email: "model@test.ru", password: "password",
        password_confirmation: "password",
        name: 'Model_test', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000, 
        confirmed_at: '2023-07-21 10:25:15.076243'
      ) if User.find_by(email: 'model@test.ru').nil?
    end

    it 'should be error if input is not unique' do
      u = User.new(email: "model@test.ru", password: "password",
        password_confirmation: "password",
        name: 'Model_test', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Эта электронная почта уже используется"])
    end
  end

  describe 'If adding correct params' do
    before do
      User.destroy_by(email: 'model@test.ru')
    end

    it 'should be without errors' do
      u = User.new(email: "model@test.ru", password: "password", 
        password_confirmation: 'password',
        name: 'Model_test', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be true
      expect(u.errors.objects.map(&:message)).to eq([])
    end

    it 'if empty middle name' do
      u = User.new(email: "model@test.ru", password: "password",
        password_confirmation: "password",
        name: 'Model_name', surname: "Model_surname", 
        middle_name: "", year: 2000
      )
      expect(u.valid?).to be true
      expect(u.errors.objects.map(&:message)).to eq([])
    end
  end

  describe 'If adding incorrect params' do
    before do
      User.destroy_by(email: 'model@test.ru')
    end

    it 'if incorrect password confirmation' do
      u = User.new(email: "model@test.ru", password: "password",
        password_confirmation: 'passwordess',
        name: 'Model_test', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Пароли не совпадают"])
    end

    it 'if empty password confirmation' do
      u = User.new(email: "model@test.ru", password: "password",
        name: 'Model_test', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Пароль нужно подтвердить"])
    end

    it 'if incorrect email address' do
      u = User.new(email: "modeltest.ru", password: "password",
        password_confirmation: "password",
        name: 'Model_test', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Некорректный формат электронной почты"])
    end

    it 'if incorrect length password' do
      u = User.new(email: "model@test.ru", password: "pass",
        password_confirmation: "pass",
        name: 'Model_test', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Минимальная длина пароля 8 символов"])
    end

    it 'if empty name' do
      u = User.new(email: "model@test.ru", password: "password",
        password_confirmation: "password",
        name: '', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Имя должно присутствовать"])
    end

    it 'if empty surname' do
      u = User.new(email: "model@test.ru", password: "password",
        password_confirmation: "password",
        name: 'Model_name', surname: "", 
        middle_name: "Model_middle_name", year: 2000
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Фамилия должна присутствовать"])
    end

    it 'if empty year' do
      u = User.new(email: "model@test.ru", password: "password",
        password_confirmation: "password",
        name: 'Model_name', surname: "Model_surname", 
        middle_name: "Model_middle_name"
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Год выпуска должен присутствовать", "Такой год невозможен"])
    end

    it 'if incorrect year' do
      u = User.new(email: "model@test.ru", password: "password",
        password_confirmation: "password",
        name: 'Model_name', surname: "Model_surname", 
        middle_name: "Model_middle_name", year: 1950
      )
      expect(u.valid?).to be false
      expect(u.errors.objects.map(&:message)).to eq(["Такой год невозможен"])
    end
  end
end

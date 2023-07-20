class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable
  
  validates :email, {
    presence: {
      message: "Электронная почта должна быть заполнена"
    },
    uniqueness: {
      message: "Эта электронная почта уже используется"
    },
    format: {
      with: /(?:[a-z0-9!#$%&'*+\=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/,
      message: "Некорректный формат электронной почты"
    }
  }

  validates :password, {
    length: {
      minimum: 8,
      message: "Минимальная длина пароля 8 символов"
    }
  }

  validates :name, {
    presence: {
      message: "Имя должна присутствовать"
    }
  }

  validates :surname, {
    presence: {
      message: "Фамилия должна присутствовать"
    }
  }

  validates :year, {
    presence: {
      message: "Год выпуска должен присутствовать"
    },
    numericality: {
      greater_than: 1952,
      less_than_or_equal_to: Time.now.year,
      message: "Такой год невозможен"
    }
  }

  validates :role, {
    presence: {
      message: "Role can't be empty"
    },
    format: {
      with: /\A(admin|user)\z/,
      message: "Incorrect role"
    }
  }
end

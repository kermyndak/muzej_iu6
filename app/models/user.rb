class User < ApplicationRecord
  has_many :requests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable, :confirmable

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

  validates_confirmation_of :password, {
    message: 'Пароли не совпадают'
  }

  validates_presence_of :password_confirmation, {
    message: 'Пароль нужно подтвердить'
  }

  validates :name, {
    presence: {
      message: "Имя должно присутствовать"
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

  def change_password(user_params)
    current_password = user_params.delete(:current_password)

    if self.valid_password?(current_password)
      if self.update(user_params)
        true
      else
        self.valid?
        false
      end      
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid, message: 'Текущий пароль другой')
      false
    end
  end

  def generate_password(set=false)
    if set
      self.password = (1..12).map { |_| [('a'..'z').to_a[rand(28)], ('0'..'9').to_a[rand(10)], ['!', '~', '@', '#', '$', '%', '^', '&', '*'][rand(9)]][rand(3)] }.join
      self.password_confirmation = self.password
    else
      (1..12).map { |_| [('a'..'z').to_a[rand(28)], ('0'..'9').to_a[rand(10)], ['!', '~', '@', '#', '$', '%', '^', '&', '*'][rand(9)]][rand(3)] }.join
    end
  end

  def create_user_without_confirmation(params)
    begin
      self.email = params[:email]
      self.name = params[:name]
      self.surname = params[:surname]
      self.middle_name = params[:middle_name]
      self.year = params[:year]
      self.confirm
    rescue ActiveRecord::RecordNotUnique
      self.errors.add(:email, "Эта почта уже используется")
      return false
    else
      unless self.valid?
        return false
      end
      self.save
      return true
    end
  end
end

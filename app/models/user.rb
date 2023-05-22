class User < ApplicationRecord
  has_many :surveys
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
  validates :contact_number, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 },
                       format: { with: /\A(?=.*[A-Z])(?=.*\W)/,
                                 message: 'must be at least 8 characters long with one uppercase letter and a special character' }
  validates :password, confirmation: true
end

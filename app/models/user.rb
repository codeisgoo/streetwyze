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



  pay_customer stripe_attributes: :stripe_attributes
  


  def stripe_attributes(pay_customer)
    {
      address:{
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metadata:{
        pay_customer_id: pay_customer.id,
        user_id: id
      }
    }
  end
end

class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  belongs_to :user 
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
  
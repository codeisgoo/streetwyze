class Question < ApplicationRecord
  belongs_to :survey
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true
  
  enum question_type: {
    open_ended: 'Open-Ended',
    multiple_choice: 'Multiple Choice'
  }

end
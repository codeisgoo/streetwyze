class Response < ApplicationRecord
  belongs_to :survey
  belongs_to :user
  belongs_to :question
end

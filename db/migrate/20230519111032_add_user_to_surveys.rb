class AddUserToSurveys < ActiveRecord::Migration[6.1]
  def change
    add_reference :surveys, :user, foreign_key: true
  end
end

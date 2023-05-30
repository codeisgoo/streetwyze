class AddBodyToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :body, :string
  end
end

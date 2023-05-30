class AddQuestionBodyToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :question_body, :string
  end
end

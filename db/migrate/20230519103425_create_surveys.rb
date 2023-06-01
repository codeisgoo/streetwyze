class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.string :title
      t.text :survey_script
      t.boolean :published

      t.timestamps
    end
  end
end

class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.references :survey, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

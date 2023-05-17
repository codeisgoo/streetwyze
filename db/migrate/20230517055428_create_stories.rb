class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :place_name
      t.string :address
      t.string :type_of_stuff
      t.string :category
      t.string :rating
      t.text :story_description
      t.string :media

      t.timestamps
    end
  end
end

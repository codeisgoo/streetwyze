# frozen_string_literal: true

class CreateAssers < ActiveRecord::Migration[6.1]
  def change
    create_table :assers do |t|
      t.string :place_name
      t.string :address
      t.string :type_of_stuff
      t.string :category
      t.integer :rating
      t.text :story_description
      t.string :media

      t.timestamps
    end
  end
end

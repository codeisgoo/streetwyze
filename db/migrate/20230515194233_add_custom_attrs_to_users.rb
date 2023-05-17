# frozen_string_literal: true

class AddCustomAttrsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :contact_number, :string
  end
end

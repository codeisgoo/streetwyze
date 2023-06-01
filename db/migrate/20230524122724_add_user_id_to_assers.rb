class AddUserIdToAssers < ActiveRecord::Migration[6.1]
  def change
    add_column :assers, :user_id, :integer
  end
end

class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :active, :boolean, default: false
    add_column :users, :blocked, :boolean, default: false
  end
end

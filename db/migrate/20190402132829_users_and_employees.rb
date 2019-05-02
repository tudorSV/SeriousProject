class UsersAndEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.boolean :admin, default: :false
      t.string :email
      t.string :phone_number

      t.references :address
      t.timestamps
    end

    create_table :employees do |t|
      t.string :role

      t.references :user
      t.references :company
      t.references :shop
      t.references :address
      t.timestamps
    end
  end
end

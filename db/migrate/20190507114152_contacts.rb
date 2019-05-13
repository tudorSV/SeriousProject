class Contacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :message
      t.references :user

      t.timestamps
    end
  end
end

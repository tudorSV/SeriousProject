class CreateMigrations < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :email
      t.boolean :active, default: :true

      t.references :company
      t.references :address
      t.timestamps
    end

    create_table :addresses do |t|
      t.string :short_address
      t.string :full_address
      t.string :city
      t.string :zipcode
      t.string :country

      t.timestamps
    end

    create_table :companies do |t|
      t.string :name
      t.string :email
      t.boolean :active, default: :true

      t.timestamps
    end
  end
end


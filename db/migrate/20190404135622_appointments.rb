class Appointments < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_slots do |t|
      t.integer :day
      t.integer :max_appointments
      t.time :open
      t.time :close
      t.boolean :closed, default: true
      t.references :shop

      t.timestamps
    end

    create_table :appointments do |t|
      t.date :date
      t.integer :item_number
      t.string :status, default: 'Booked'

      t.references :user
      t.references :shop
      t.timestamps
    end
  end
end

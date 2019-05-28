class AddNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :message
      t.references :appointment
      t.references :user

      t.timestamps
    end
  end
end

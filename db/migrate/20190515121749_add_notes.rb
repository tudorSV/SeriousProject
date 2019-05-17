class AddNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :message
      t.references :appointment

      t.timestamps
    end
  end
end

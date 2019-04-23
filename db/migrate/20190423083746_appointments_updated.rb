class AppointmentsUpdated < ActiveRecord::Migration[5.2]
  def change
   change_column_default :appointments, :status, from: 'Booked', to: 'booked'
  end
end

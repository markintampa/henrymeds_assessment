class CreateAppointmentSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :appointment_slots do |t|
      t.string :provider_id
      t.string :client_id, null: true
      t.datetime :start_time
      t.datetime :reserved_at
      t.string :reserved_by
      t.boolean :confirmed

      t.timestamps
    end
  end
end

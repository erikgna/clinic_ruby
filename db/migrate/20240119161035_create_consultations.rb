class CreateConsultations < ActiveRecord::Migration[7.1]
  def change
    create_table :consultations, id: :uuid do |t|
      t.references :doctor, null: false, foreign_key: true, type: :uuid
      t.references :patient, null: false, foreign_key: true, type: :uuid
      t.datetime :scheduled_at
      t.text :notes
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index [:doctor_id, :patient_id], unique: true
      t.index :scheduled_at
    end
  end
end

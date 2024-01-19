class CreateMedicalRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :medical_records, id: :uuid do |t|
      t.references :patient, type: :uuid, null: false, foreign_key: true
      t.references :consultation, type: :uuid, null: false, foreign_key: true
      t.string :file_key, null: false

      t.timestamps
    end
  end
end

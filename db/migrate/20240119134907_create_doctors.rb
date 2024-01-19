class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :name
      t.string :specialization
      t.integer :experience_years

      t.timestamps
    end
  end
end

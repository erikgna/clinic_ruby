class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :name
      t.integer :age
      t.string :gender
      t.text :diagnosis

      t.timestamps
    end
  end
end

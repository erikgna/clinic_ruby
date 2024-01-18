class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.text :diagnosis

      t.timestamps
    end
  end
end

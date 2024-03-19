class CreateBirds < ActiveRecord::Migration[7.1]
  def change
    create_table :birds do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :birds, :name, unique: true
  end
end

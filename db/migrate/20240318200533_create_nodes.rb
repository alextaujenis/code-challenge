class CreateNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :nodes do |t|
      t.integer :parent_id
    end
    add_index :nodes, :parent_id
  end
end

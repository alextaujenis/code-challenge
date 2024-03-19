class CreateNodesBirds < ActiveRecord::Migration[7.1]
  def change
    create_table :birds_nodes do |t|
      t.references :bird, null: false, foreign_key: true
      t.references :node, null: false, foreign_key: true
    end
  end
end

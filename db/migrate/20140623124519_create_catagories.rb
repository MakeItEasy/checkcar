class CreateCatagories < ActiveRecord::Migration
  def change
    create_table :catagories do |t|
      t.string :name, null: false, default: "", limit: 10
      t.integer :order, null: false 
      t.text :memo

      t.timestamps
    end

    add_index :catagories, :name, unique: true
    add_index :catagories, :order, unique: true
  end
end

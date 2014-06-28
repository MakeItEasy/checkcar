class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name, null: false, default: ""
      t.string :province, null: false
      t.string :city, null: false
      t.string :district, null: false
      t.string :address, null: false, default: ""
      t.string :telephone, null: false, default: ""
      # 状态
      t.string :status, null: false
      # 审核者
      t.integer :check_user_id
      # 拒绝理由
      t.text :reject_reason
      # 锁定者
      t.integer :lock_user_id
      t.text :recommend

      t.timestamps
    end

    add_index :stations, :name, unique: true
    add_index :stations, :province
    add_index :stations, :city
    add_index :stations, :district
  end
end

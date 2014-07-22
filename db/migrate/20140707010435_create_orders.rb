class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      # 预约类型
      t.string :type, null: false
      # 预约流水号
      t.string :order_no, null: false
      # 预约者ID
      t.integer :user_id
      # 预约车检站
      t.integer :station_id, null: false
      # 预约时间
      t.datetime :order_time, null: false
      # 车主姓名
      t.string :owner_name, null: false 
      # 车牌号码
      t.string :car_number_area, null: false 
      t.string :car_number_detail, null: false 
      # 预留手机号
      t.string :telephone, null: false
      # 预约状态
      t.string :status, null: false
      # 创建者
      t.integer :create_admin_id

      t.timestamps
    end

    add_index :orders, :user_id
    add_index :orders, :station_id
    add_index :orders, :order_no
    add_index :orders, :status
  end
end

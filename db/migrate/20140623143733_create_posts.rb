class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      # 标题
      t.string :title, null: false, default: ""
      # 分类ID
      t.integer :catagory_id, null: false
      # 内容
      t.text :content, null: false 
      # 状态
      t.string :status, null: false
      # 创建者
      t.integer :create_user_id, null: false
      # 审核者
      t.integer :check_user_id
      # 拒绝理由
      t.text :reject_reason
      # 锁定者
      t.integer :lock_user_id

      t.timestamps
    end

    add_index :posts, :title
    add_index :posts, :catagory_id
    add_index :posts, :status
    add_index :posts, :create_user_id
  end
end

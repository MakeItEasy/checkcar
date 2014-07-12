class CreateUaqs < ActiveRecord::Migration
  def change
    create_table :uaqs do |t|
      # 提问者
      t.integer :user_id, null:false
      t.text :question, null:false
      # 回答者
      t.integer :answered_admin_id
      # 回答时间
      t.datetime :answered_time
      t.text :answer

      t.timestamps
    end

    add_index :uaqs, :user_id
    add_index :uaqs, :answered_admin_id
  end
end

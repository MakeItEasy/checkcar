class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :question, null:false
      t.text :answer, null:false
      # 创建者
      t.integer :create_user_id, null: false

      t.timestamps
    end

    add_index :faqs, :question
    add_index :faqs, :create_user_id
  end
end

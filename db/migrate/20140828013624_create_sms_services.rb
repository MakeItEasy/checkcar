class CreateSmsServices < ActiveRecord::Migration
  def change
    create_table :sms_services do |t|
      # 发送手机号
      t.string :telephone
      # 描述
      t.string :description
      # 参数hash
      t.text :options
      # HTTP返回response code
      t.integer :response_code
      # API返回code
      t.integer :api_code
      # API返回message
      t.string :api_msg
      # API返回结果
      t.text :result

      t.timestamps
    end

    add_index :sms_services, :telephone
  end
end
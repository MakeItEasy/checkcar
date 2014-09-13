class CreateOpenCities < ActiveRecord::Migration
  def change
    create_table :open_cities do |t|
      # 名称：西安
      t.string :name, null: false
      # 省code
      t.string :province_code, null: false
      # 城市code
      t.string :city_code, null: false
      # 略称(用于subdomain)：xa
      t.string :short_name, null: false

      t.timestamps
    end

    add_index :open_cities, :short_name, unique: true
    add_index :open_cities, :city_code, unique: true
  end
end

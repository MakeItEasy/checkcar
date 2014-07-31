class AddMapInfoToStations < ActiveRecord::Migration
  def change
    add_column :stations, :jingdu, :double
    add_column :stations, :weidu, :double
  end
end

class AddLogoToStations < ActiveRecord::Migration
  def self.up
    add_attachment :stations, :logo
  end

  def self.down
    remove_attachment :stations, :logo
  end
end

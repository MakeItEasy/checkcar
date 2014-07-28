class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.attachment :data
      t.references :resource, :polymorphic => true
      t.timestamps
    end
  end
end

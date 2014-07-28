class Picture < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true

  has_attached_file :data, :styles => { :medium => "525x290^" }

  validates_attachment_content_type :data, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :data, :less_than => 2.megabytes
end

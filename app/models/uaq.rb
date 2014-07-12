class Uaq < ActiveRecord::Base

  ## Associations
  belongs_to :user
  belongs_to :admin, foreign_key: :answered_admin_id

  ## Validates
  validates :question, presence: true
end

class Faq < ActiveRecord::Base
  ## Associations
  belongs_to :admin, foreign_key: :create_user_id

  ## Validates
  validates :question, presence: true, length: { maximum: 50 }
  validates :answer, presence: true
end

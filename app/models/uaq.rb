class Uaq < ActiveRecord::Base

  attr_accessor :answering

  ## Scopes
  default_scope { order(updated_at: :desc) }
  scope :answered, -> { where("answered_admin_id is not null") }
  scope :wait_answer, -> { where("answered_admin_id is null") }

  ## Associations
  belongs_to :user
  belongs_to :admin, foreign_key: :answered_admin_id

  ## Validates
  validates :question, presence: true
  validates :answer, presence: true, if: "answering"

  def answered?
    self.answered_admin_id.present?
  end

end

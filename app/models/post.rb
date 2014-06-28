class Post < ActiveRecord::Base
  extend Enumerize

  ## Scopes
  default_scope { order(updated_at: :desc) }
  scope :draft, -> { with_status(:draft) }
  scope :waiting, -> { with_status(:waiting) }
  scope :published, -> { with_status(:published) }
  scope :rejected, -> { with_status(:rejected) }
  scope :locked, -> { with_status(:locked) }
  scope :default_order, -> { order(updated_at: :desc) }

  ## Validates
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :catagory, presence: true
  enumerize :status, in: Car::Code::POST_STATUS, default: :draft, predicates: { prefix: true }, scope: true


  ## Associations
  belongs_to :admin, foreign_key: :create_user_id
  belongs_to :catagory

  # 前一篇已发布文章
  def pre_published_post
    Post.published
      .where("updated_at < :updated_at and catagory_id = :catagory_id",
             {updated_at: self.updated_at, catagory_id: self.catagory_id})
      .first
  end

  # 后一篇已发布文章
  def next_published_post
    Post.published
      .where("updated_at > :updated_at and catagory_id = :catagory_id",
             {updated_at: self.updated_at, catagory_id: self.catagory_id})
      .last
  end

  # 审核者
  def check_user
    Admin.find_by_id(self.check_user_id)
  end

  # 锁定者
  def lock_user
    Admin.find_by_id(self.lock_user_id)
  end

end

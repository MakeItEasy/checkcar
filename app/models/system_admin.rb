class SystemAdmin < Admin
  ## Associations
  has_many :posts, foreign_key: :create_user_id

  ## 角色管理
  # rolify
  
end

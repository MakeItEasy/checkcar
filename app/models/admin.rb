class Admin < ActiveRecord::Base
  extend Enumerize
  ## 角色管理
  rolify

  # 针对当前密码，和password是否必需验证的判断
  attr_accessor :password_required

  ## 登录管理
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, 
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  ## Associations
  has_many :posts, foreign_key: :create_user_id
  
  ## Validations
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 30 }
  validates :password, presence: true, if: "new_record? || password_required"
  validates :telephone, presence: true
  validates :sex, presence: true
  validates :roles, presence: true
  enumerize :sex, in: Car::Code::SEX, predicates: { prefix: true }, scope: true

end

class Admin < ActiveRecord::Base
  extend Enumerize

  # 针对当前密码，和password是否必需验证的判断
  attr_accessor :password_required

  ## 登录管理
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, 
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable
  
  ## Validations
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 30 }
  validates :password, presence: true, if: "new_record? || password_required"
  validates :telephone, presence: true
  validates :sex, presence: true
  validates :roles, presence: true
  enumerize :sex, in: Car::Code::SEX, predicates: { prefix: true }, scope: true
  serialize :roles

  ## 角色判断
  def has_role?(role)
    self.roles && self.roles.include?(role)
  end

  ## 是否系统管理员
  def system_admin?
    self.is_a? SystemAdmin
  end

  ## 是否车检站管理员
  def station_admin?
    self.is_a? StationAdmin
  end

  # 自定义devise admin scope mailer
  def devise_mailer
    Devise::AdminMailer
  end
end

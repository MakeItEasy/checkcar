class User < ActiveRecord::Base
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :confirmable, :authentication_keys => [:login]

  attr_accessor :mode, :login
  # 针对当前密码，和password是否必需验证的判断
  attr_accessor :password_required

  ## Associations
  has_many :uaqs
  has_many :orders

  ## Validations
  validates_length_of :email, within: 1..30, allow_blank: true
  validates :telephone, presence: true, if: :telephone_required?
  validates :password, presence: true, if: "password_required"
  validates :password, length: { maximum: 30 }, allow_blank: true
  validates_uniqueness_of :telephone, allow_blank: true
  # 这次不验证以下两项，如果这里验证了，要保证devise的各个画面，比如密码重置画面是否能通过验证
  # validates :name, presence: true, length: { maximum: 30 }, if: "!new_record?"
  # validates :sex, presence: true, if: "!new_record?"
  enumerize :sex, in: Car::Code::SEX, predicates: { prefix: true }, scope: true
  enumerize :login_type, in: Car::Code::LOGIN_TYPE, predicates: { prefix: true }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      user = where(conditions).where(["telephone = :value OR lower(email) = :value", { :value => login.downcase }]).first
      if user.present?
        if login == user.telephone
          user.update_columns(login_type: Car::Code::LOGIN_TYPE[:telephone])
        else
          user.update_columns(login_type: Car::Code::LOGIN_TYPE[:email])
        end
      end
      user
    else
      where(conditions).first
    end
  end

  def show_name
    return self.name if self.name.present?
    return self.email if self.email.present?
    return self.telephone
  end

  def confirmed?
    if self.login_type_telephone? || self.mode == 'telephone'
      true
    else
      super
    end
  end

  def can_order?
    if self.orders.success.count >= Car::Constants::USER_ENABLE_ORDER_NUMBERS
      return I18n.t("view.alert.order.user_order_numbers_over", count: Car::Constants::USER_ENABLE_ORDER_NUMBERS)
    end
    return nil
  end

private

  def email_required?
    self.new_record? && !['telephone'].include?(self.mode)
  end

  def telephone_required?
    self.new_record? && ['telephone'].include?(self.mode)
  end
end

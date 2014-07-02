class User < ActiveRecord::Base
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :authentication_keys => [:login]

  attr_accessor :mode, :login

  ## Validations
  validates_length_of :email, within: 1..30, allow_blank: true
  validates :telephone, presence: true, if: :telephone_required?
  validates_uniqueness_of :telephone, allow_blank: true
  validates :name, presence: true, length: { maximum: 30 }, if: "!new_record?"
  validates :sex, presence: true, if: "!new_record?"
  enumerize :sex, in: Car::Code::SEX, predicates: { prefix: true }, scope: true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["telephone = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def show_name
    self.name || self.email || self.telephone
  end

private

  def email_required?
    self.new_record? && ['email'].include?(self.mode)
  end

  def telephone_required?
    self.new_record? && ['telephone'].include?(self.mode)
  end

end

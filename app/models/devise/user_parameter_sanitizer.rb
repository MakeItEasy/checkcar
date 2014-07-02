class Devise::UserParameterSanitizer < Devise::ParameterSanitizer
  def sign_in
    default_params.permit(:password, :password_confirmation, :login, :remember_me)
  end

  def sign_up
    default_params.permit(:telephone, :email, :mode, :password, :password_confirmation)
  end
end

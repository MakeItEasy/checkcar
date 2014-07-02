class Devise::UserParameterSanitizer < Devise::ParameterSanitizer
  def sign_in
    default_params.permit(:telephone, :email, :password, :password_confirmation)
  end

  def sign_up
    default_params.permit(:telephone, :email, :mode, :password, :password_confirmation)
  end
end

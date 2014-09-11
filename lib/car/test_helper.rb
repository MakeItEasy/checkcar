module Car::TestHelper
  def expect_redirect_to_user_sign_in
    expect(response).to redirect_to(new_user_session_path)
  end
end

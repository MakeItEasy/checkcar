module Car::TestHelper
  def expect_redirect_to_user_sign_in
    expect(response).to redirect_to(new_user_session_path)
  end

  def expect_redirect_to_admin_sign_in
    expect(response).to redirect_to(new_admin_session_path)
  end

  def expect_record_not_found 
    expect { yield }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

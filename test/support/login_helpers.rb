module LoginHelpers
  def login_as_admin
    @user = users(:one)
    @valid_creds = { email: @user.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @admin_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end

  def login_as_member
    @user = users(:two)
    @valid_creds = { email: @user.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @member_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end
end
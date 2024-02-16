require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should not get user info without auth_token' do
    get users_path, headers: @headers
    assert_match json['message'], Message.missing_token
  end

  test 'should get index as admin' do
    login_as_admin
    get users_path, headers: @admin_headers
    assert_response :success
    assert_equal User.count, json['data'].size
  end

  test 'should not get index as user' do
    login_as_user
    get users_path, headers: @user_headers
    assert_match Message.unauthorized, json['message']
  end
end
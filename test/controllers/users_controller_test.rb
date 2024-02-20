require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should not get user info without auth_token' do
    get users_path, headers: @headers
    assert_match json['message'], Message.missing_token
  end

  class AsAdmin < UsersControllerTest
    setup do 
      login_as_admin
    end

    test 'should get index' do
      get users_path, headers: @admin_headers
      assert_response :success
      assert_equal User.count, json['data'].size
    end

    test 'should get show' do 
      get user_path(users(:two)), headers: @admin_headers
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, users(:two).id
    end 

    test 'should create' do 
      assert_difference('User.count') do 
        post users_path, params: {
          user: {
            email: Faker::Internet.email, 
            password: 'password', 
            role: 'admin'
          }
        }.to_json, headers: @admin_headers
      end
      assert_response :success
    end 

    test 'should return 422 on invalid create' do 
      assert_no_difference('User.count') do 
        post users_path, params: {
          user: {
            email: Faker::Internet.email
          }
        }.to_json, headers: @admin_headers
      end
      assert_match Message.create_failed, json['message']
    end

    test 'should update' do 
      email = Faker::Internet.email 
      patch user_path(users(:two)), params: {
        user: {
          email: email
        }
      }.to_json, headers: @admin_headers
      assert_equal users(:two).reload.email, email
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, users(:two).id
    end 

    test 'should return 422 on invalid update' do 
      patch user_path(users(:one)), params: {
        user: {
          email: nil, 
          password: nil
        }
      }.to_json, headers: @admin_headers
      assert_match Message.update_failed, json['message']
    end

    test 'should destroy' do 
      assert_difference('User.count', -1) do 
        delete user_path(users(:two)), headers: @admin_headers
      end
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, users(:two).id
    end
  end 

  class AsMember < UsersControllerTest
    setup do 
      login_as_member
    end

    test 'should not get index as user' do
      get users_path, headers: @member_headers
      assert_match Message.unauthorized, json['message']
    end

    test 'should not show another record' do 
      get user_path(users(:one)), headers: @member_headers
      assert_match json['message'], Message.unauthorized
    end 

    test 'should show own record' do 
      get user_path(users(:two)), headers: @member_headers
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, users(:two).id
    end

    test 'should not create' do 
      assert_no_difference('User.count') do 
        post users_path, params: {
          user: {
            email: Faker::Internet.email, 
            password: 'password', 
            role: 'member'
          }
        }.to_json, headers: @member_headers
      end
      assert_match json['message'], Message.unauthorized
    end 

    test 'should not update another record' do 
      patch user_path(users(:one)), headers: @member_headers
      assert_match json['message'], Message.unauthorized
    end 

    test 'should update own record' do 
      email = Faker::Internet.email 
      patch user_path(users(:two)), params: {
        email: email, 
        password: users(:two).password
      }.to_json, headers: @member_headers
      assert_equal users(:two).reload.email, email
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, users(:two).id
    end

    test 'should not update own role' do 
      admin = 'admin'
      patch user_path(users(:two)), params: {
        user: {
          role: admin
        }
      }.to_json, headers: @member_headers
      refute_equal users(:two).reload.role, admin
      assert_match json['message'], Message.update_failed
    end

    test 'should not destroy another record' do 
      delete user_path(users(:one)), headers: @member_headers
      assert_match json['message'], Message.unauthorized
    end 

    test 'should destroy own record' do 
      assert_difference('User.count', -1) do 
        delete user_path(users(:two)), headers: @member_headers
      end
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, users(:two).id
    end
  end

  

  
end
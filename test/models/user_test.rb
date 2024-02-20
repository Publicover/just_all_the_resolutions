require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should have columns' do
    assert User.column_names.include?('email')
    assert User.column_names.include?('password_digest')
    assert User.column_names.include?('role')
  end

  test 'should retrieve by enum' do
    assert_equal User.where(role: :admin).count, User.admin.count
    assert_equal User.where(role: :member).count, User.member.count
    assert_equal User.count, User.admin.count + User.member.count
  end

  test 'should validate email' do 
    user = User.new(password: Faker::Internet.email)
    assert_not user.save
  end 

  test 'should validate password' do 
    user = User.new(password: Faker::Lorem.word)
    assert_not user.save
  end 

  test 'should default member role on create' do
    user = User.create(email: 'some@guy.com', password: 'password')
    assert user.member?
  end  
end
require "test_helper"

class FoodsControllerTest < ActionDispatch::IntegrationTest
  class AsAdmin < FoodsControllerTest
    setup do 
      login_as_admin
    end

    test 'should get index' do
      get foods_path, headers: @admin_headers
      assert_response :success
      assert_equal Food.count, json['data'].size
    end

    test 'should get show' do
      get food_path(foods(:one)), headers: @admin_headers
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, foods(:one).id
    end

    test 'should create' do
      assert_difference('Food.count') do
        post foods_path, params: {
          food: {
            name: Faker::Food.ingredient,
            kcal_per_100g: Faker::Number.number(digits: 3)
          }
        }.to_json, headers: @admin_headers
      end
      assert_response :created
    end

    test 'should return 422 if invalid create' do 
      assert_no_difference('Food.count') do 
        post users_path, params: {
          user: {
            name: Faker::Lorem.word
          }
        }.to_json, headers: @admin_headers
      end
      assert_match Message.create_failed, json['message']
    end

    test 'should update' do 
      name = Faker::Food.ingredient
      patch food_path(foods(:one)), params: {
        food: {
          name: name
        }
      }.to_json, headers: @admin_headers
      assert_equal foods(:one).reload.name, name
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, foods(:one).id
    end

    test 'should return 422 if invalid update' do 
      patch food_path(foods(:one)), params: {
        food: {
          name: nil, 
          kcal_per_100g: nil
        }
      }.to_json, headers: @admin_headers
      assert_match Message.update_failed, json['message']
    end

    test 'should destroy' do 
      assert_difference('Food.count', -1) do 
        delete food_path(foods(:one)), headers: @admin_headers
      end
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, foods(:one).id
    end
  end

  class AsMember < FoodsControllerTest
    setup do 
      login_as_member
    end

    test 'should get index' do 
      get foods_path, headers: @member_headers
      assert_response :success
      assert_equal Food.count, json['data'].size
    end

    test 'should get show' do 
      get food_path(foods(:one)), headers: @member_headers
      assert_response :success
      assert_equal json['data']['attributes']['id'].to_i, foods(:one).id
    end 

    test 'should not create' do 
      assert_no_difference('Food.count') do
        post foods_path, params: {
          food: {
            name: Faker::Food.ingredient,
            kcal_per_100g: Faker::Number.number(digits: 3)
          }
        }.to_json, headers: @member_headers
      end
      assert_match json['message'], Message.unauthorized
    end

    test 'should not update' do 
      name = Faker::Food.ingredient
      food = patch food_path(foods(:one)), params: {
        food: {
          name: name
        }
      }.to_json, headers: @member_headers
      assert_match json['message'], Message.unauthorized
    end

    test 'should not destroy' do 
      delete food_path(foods(:one)), headers: @member_headers
      assert_match json['message'], Message.unauthorized
    end
  end
end
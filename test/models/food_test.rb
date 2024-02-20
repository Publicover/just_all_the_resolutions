require "test_helper"

class FoodTest < ActiveSupport::TestCase
  test 'should have columns' do 
    assert Food.column_names.include?('name')
    assert Food.column_names.include?('kcal_per_100g')
  end 

  test 'should know calories per gram' do 
    assert_equal foods(:one).kcal_per_gram, foods(:one).kcal_per_100g / 100.0
  end

  test 'should validate name' do 
    food = Food.new(kcal_per_100g: Faker::Number.number(digits: 3))
    assert_not food.save
  end 

  test 'should validate kcal per 100g' do 
    food = Food.new(name: Faker::Lorem.word)
    assert_not food.save
  end
end

require "test_helper"

class FoodTest < ActiveSupport::TestCase
  test 'should have columns' do 
    assert Food.column_names.include?('name')
    assert Food.column_names.include?('kcal_per_100g')
  end 

  test 'should know calories per gram' do 
    assert_equal foods(:one).kcal_per_gram, foods(:one).kcal_per_100g / 100.0
  end
end

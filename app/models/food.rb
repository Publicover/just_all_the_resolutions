# frozen_string_literal: true

class Food < ApplicationRecord
  def kcal_per_gram
    kcal_per_100g / 100.0
  end
end

# frozen_string_literal: true

class Food < ApplicationRecord
  validates :name, :kcal_per_100g, on: :create, presence: true
  validates :name, :kcal_per_100g, on: :update, presence: true, if: proc { name.nil? || kcal_per_100g.nil? }

  def kcal_per_gram
    kcal_per_100g / 100.0
  end
end

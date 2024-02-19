# frozen_string_literal: true

class FoodSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :kcal_per_100g, :created_at
end

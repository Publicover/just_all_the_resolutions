# frozen_string_literal: true

class FoodPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user?
  end

  def show?
    user?
  end

  def create?
    admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def permitted_attributes
    [:name, :kcal_per_100g]
  end
end

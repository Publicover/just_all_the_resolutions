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
    index?
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
    [:email, :password, :role]
  end
end

# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    admin?
  end

  def show?
    admin_or_owner?
  end

  def create?
    index?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  def permitted_attributes
    [:email, :password, :role]
  end
end

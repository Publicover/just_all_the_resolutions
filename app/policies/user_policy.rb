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
    return true if user.admin?
    return true if record.id == user.id

    false
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

  def base_attributes
    [:email, :password]
  end

  def admin_attributes
    [:role]
  end

  def member_attributes
    []
  end

  def permitted_attributes
    return base_attributes.concat(admin_attributes) if user.admin?
    return base_attributes.concat(member_attributes) if user.member?

    []
  end
end

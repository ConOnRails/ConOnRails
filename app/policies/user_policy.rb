# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Admins get all; user gets only themselves
      return scope.all if user.can_admin_users?

      scope.where(id: user.id)
    end
  end

  def index?
    user.can_admin_users?
  end

  def show?
    user.id == record.id || user.can_admin_users?
  end

  def create?
    show?
  end

  def update?
    show?
  end

  def change_password?
    show?
  end

  def destroy?
    user.can_admin_users?
  end
end

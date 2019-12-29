class RolePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.can_admin_users?
  end

  def show?
    user.can_admin_users?
  end

  def create?
    user.can_admin_users?
  end

  def update?
    user.can_admin_users?
  end

  def destroy?
    user.can_admin_users?
  end
end


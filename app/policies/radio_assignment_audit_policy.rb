class RadioAssignmentAuditPolicy < ApplicationPolicy
  def index?
    user.can_admin_radios?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end
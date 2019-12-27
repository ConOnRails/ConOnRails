class RadioAssignmentPolicy < ApplicationPolicy
  def checkout?
    user.can_assign_radios?
  end

  def create?
    checkout?
  end

  def update?
    checkout?
  end

  def destroy?
    checkout?
  end

  def select_department?
    checkout?
  end
end
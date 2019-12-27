class DutyBoardGroupPolicy < ApplicationPolicy
  def index?
    user.can_admin_duty_board?
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
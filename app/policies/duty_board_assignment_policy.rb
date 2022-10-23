# frozen_string_literal: true

class DutyBoardAssignmentPolicy < ApplicationPolicy
  def create?
    user.can_assign_duty_board_slots?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end

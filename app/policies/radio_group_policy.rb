# frozen_string_literal: true

class RadioGroupPolicy < ApplicationPolicy
  def index?
    user.can_assign_radios?
  end

  def show?
    index?
  end

  def create?
    user.can_admin_radios?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end

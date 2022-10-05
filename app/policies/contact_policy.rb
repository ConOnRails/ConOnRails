# frozen_string_literal: true

class ContactPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.can_write_entries?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end

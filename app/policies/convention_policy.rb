# frozen_string_literal: true

class ConventionPolicy < ApplicationPolicy
  def index?
    user.can_read_audits?
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

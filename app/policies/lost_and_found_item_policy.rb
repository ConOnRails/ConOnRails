# frozen_string_literal: true

class LostAndFoundItemPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.add_lost_and_found?
  end

  def update?
    user.modify_lost_and_found?
  end
end

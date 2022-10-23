# frozen_string_literal: true

class LostAndFoundPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end

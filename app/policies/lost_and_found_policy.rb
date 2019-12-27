class LostAndFoundPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
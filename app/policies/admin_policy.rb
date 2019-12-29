class AdminPolicy < ApplicationPolicy
  def index?
    user.can_admin_anything?
  end
end
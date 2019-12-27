class RadioAdminPolicy < ApplicationPolicy
  def index?
    user.can_admin_radios?
  end
end
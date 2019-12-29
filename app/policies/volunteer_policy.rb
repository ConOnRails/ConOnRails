class VolunteerPolicy < ApplicationPolicy
  def search_volunteers?
    user.can_assign_radios?
  end

  def index?
    user.can_admin_users?
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

  def clear_all_radio_training?
    index?
  end
end
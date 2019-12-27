class RadioPolicy < ApplicationPolicy
  def index?
    user.can_assign_radios?
  end

  def show?
    index?
  end

  def search_volunteers?
    index?
  end

  def select_department?
    index?
  end

  def checkout?
    index?
  end

  def transfer?
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
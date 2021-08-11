class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # By default, filter out secure and hidden
      scope.all
    end
  end

  def index?
    user.present? # Right now anyone who is a user can read the main log
  end

  def sticky?
    index?
  end

  def secure?
    index? && user.can_read_secure?
  end

  def review?
    index?
  end

  def export?
    review?
  end

  def search_entries?
    index?
  end

  def tag?
    index?
  end

  def show?
    if record.hidden?
      user.can_read_hidden?
    elsif record.secure?
      user.can_read_secure?
    else
      index?
    end
  end

  def create?
    index? && user.can_write_entries?
  end

  def update?
    index? && user.can_write_entries?
  end

  def merge_events?
    index? && create?
  end

end

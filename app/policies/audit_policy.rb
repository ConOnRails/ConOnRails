class AuditPolicy < ApplicationPolicy
  def index?
    user.can_read_audits?
  end
end
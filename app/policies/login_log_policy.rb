# frozen_string_literal: true

class LoginLogPolicy < ApplicationPolicy
  def index?
    user.can_read_audits?
  end
end

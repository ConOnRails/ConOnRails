# frozen_string_literal: true

class RadioAdminController < ApplicationController
  skip_after_action :verify_policy_scoped

  def index
    authorize :radio_admin
  end
end

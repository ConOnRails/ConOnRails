class RadioAssignmentAuditsController < ApplicationController
  load_and_authorize_resource

  respond_to :html
end

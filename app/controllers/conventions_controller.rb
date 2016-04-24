# == Schema Information
#
# Table name: conventions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ConventionsController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  before_filter :set_conventions, only: [:index]

  # POST /conventions
  # POST /conventions.json
  def create
    flash[:notice] = 'Convention was successfully created.' if @convention.save
    respond_with @convention, location: :conventions
  end

  # PUT /conventions/1
  # PUT /conventions/1.json
  def update
    flash[:notice] = 'Convention was successfully updated.' if @convention.update_attributes convention_params
    respond_with @convention, location: :conventions
  end

  protected

  def set_conventions
    @q = Convention.search params[:q]
    @q.sorts = ['start_date desc'] if @q.sorts.empty?
    @conventions = @q.result.page(params[:page])
  end

  def convention_params
    params.require(:convention).permit :end_date, :name, :start_date
  end

end

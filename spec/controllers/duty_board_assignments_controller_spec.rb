# == Schema Information
#
# Table name: duty_board_assignments
#
#  id                 :integer          not null, primary key
#  duty_board_slot_id :integer
#  notes              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  name               :string(255)
#  string             :string(255)
#

require 'spec_helper'

describe DutyBoardAssignmentsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end

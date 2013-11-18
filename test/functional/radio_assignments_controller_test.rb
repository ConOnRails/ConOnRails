require 'test_helper'

class RadioAssignmentsControllerTest < ActionController::TestCase
  setup do
    @radio_assignment = FactoryGirl.build :valid_radio_assignment
    @user             = FactoryGirl.create :user
    @role             = FactoryGirl.create :assign_radios_role
    @radio            = FactoryGirl.create :valid_blue_radio
    @department       = FactoryGirl.create :good_department, radio_allotment: 2
    @volunteer        = FactoryGirl.create :valid_volunteer, can_have_multiple_radios: true
    @user.roles << @role
    @user_session = { user_id: @user.id }
  end

  test "should create radio_assignment" do
    assert_difference('RadioAssignmentAudit.count') do
      assert_difference('RadioAssignment.count') do
        xhr :post, :create,
            { radio_assignment: FactoryGirl.attributes_for(:valid_radio_assignment, volunteer_id: @volunteer.id, radio_id: @radio.id, department_id: @department.id), format: :js },
            @user_session
      end
    end
    assert_equal "out", assigns(:radio_assignment).radio.state
    assert_response :ok
  end

  test "should destroy radio_assignment" do
    radio       = @radio_assignment.radio
    radio.state = "out"
    @radio_assignment.save!
    radio_id = radio.id
    assert_difference 'RadioAssignmentAudit.count' do
      assert_difference('RadioAssignment.count', -1) do
        delete :destroy, { id: @radio_assignment.to_param }, @user_session
      end
    end
    assert_equal "in", Radio.find_by_id(radio_id).state
    assert_redirected_to radios_path
  end

  user_context :admin_user do
    context 'PUT :update' do
      setup do
        radio       = @radio_assignment.radio
        radio.state = "out"
        @radio_assignment.save!
        RadioAssignmentAudit.audit_checkout(@radio_assignment, @user)

        @audit_count = RadioAssignmentAudit.count
        @count       = RadioAssignment.count
      end

      context 'With 2 radios permitted' do
        setup do
          xhr :put, :update,
              { id: @radio_assignment.id, radio_assignment: { volunteer_id: @volunteer.id, department_id: @department.id }, format: :js },
              @user_session
        end
        should respond_with :ok
        should render_template 'success'

        should 'have right counts' do
          assert_no_match /NOT/, flash[:notice]
          assert_equal @count, RadioAssignment.count
          # There should be a check in and check out audit in addition to the original checkout.
          assert_equal @audit_count + 1, RadioAssignmentAudit.count
        end
      end

      context 'With 1 radio permitted' do
        setup do
          @department.update_attribute(:radio_allotment, 1)
          xhr :put, :update,
              { id: @radio_assignment.id, radio_assignment: { volunteer_id: @volunteer.id, department_id: @department.id }, format: :js },
              @user_session
        end
        should respond_with :ok
        should render_template 'error'
      end
    end
  end
end

require 'test_helper'

class VspsControllerTest < ActionController::TestCase
  user_context :admin_context do
    context 'GET :index' do
      setup do
        get :index
      end

      should respond_with :success
    end

    context 'GET :new' do
      setup do
        get :new
      end

      should respond_with :success
    end

    context 'POST :create' do
      setup do
        post :create, vsp: FactoryGirl.attributes_for(:vsp)
      end
      should respond_with :redirect
      should redirect_to('vsp list') { vsps_path }
    end

    context 'POST :update' do
      setup do
        @vsp = FactoryGirl.create :vsp
        post :update, id: @vsp.id, vsp: { notes: 'Wombat' }
      end

      should respond_with :redirect
      should redirect_to('vsp list') { vsps_path }
    end

    context 'GET :edit' do
      setup do
        @vsp = FactoryGirl.create :vsp
        get :edit, id: @vsp.id
      end

      should respond_with :success
    end
  end

  user_context :typical_context do
    [:index, :new, :edit].each do |x|
      context "GET #{x}" do
        setup do
          get x, id: 42
        end
        should respond_with :redirect
      end
    end

    context 'POST :create' do
      setup do
        post :create
      end

      should respond_with :redirect
    end

    context 'PUT :update' do
      setup do
        put :update, id: 42
      end
      should respond_with :redirect
    end

  end



end

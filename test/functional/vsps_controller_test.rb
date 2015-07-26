require 'test_helper'

class VspsControllerTest < ActionController::TestCase
  user_context :admin_context do
    context 'GET :index' do
      setup do
        get :index
      end

      should respond_with :success
      should render_template :index
    end

    context 'GET :new' do
      setup do
        get :new
      end

      should respond_with :success
      should render_template :new
    end

    context 'POST :create' do
      context 'blank attributes' do
        setup do
          post :create, vsp: { name: '' }
        end
        should respond_with :success
        should render_template :new
        should_not set_flash.to %r[created successfully!$]
      end

      context 'correct attributes' do
        setup do
          post :create, vsp: FactoryGirl.attributes_for(:vsp)
        end
        should respond_with :redirect
        should redirect_to('vsp list') { vsps_path }
        should set_flash.to %r[created successfully!$]
      end
    end

    context 'PATCH :update' do
      setup do
        @vsp = FactoryGirl.create :vsp
      end

      context 'bad params' do
        setup do
          patch :update, id: @vsp.id, vsp: { name: '' }
        end
        should respond_with :success
        should render_template :edit
        should_not set_flash.to %r[updated successfully!$]
      end

      context 'good params' do
        setup do
          patch :update, id: @vsp.id, vsp: { notes: 'Wombat' }
        end

        should respond_with :redirect
        should redirect_to('vsp list') { vsps_path }
        should set_flash.to %r[updated successfully!$]
      end
    end

    context 'GET :edit' do
      setup do
        @vsp = FactoryGirl.create :vsp
        get :edit, id: @vsp.id
      end

      should respond_with :success
      should render_template :edit
    end
  end

  user_context :typical_context do
    [:index, :new, :edit].each do |x|
      context "GET #{x}" do
        setup do
          @vsp = FactoryGirl.create :vsp
          get x, id: @vsp.id
        end
        should respond_with :redirect
        should redirect_to('public') { public_path }
      end
    end

    context 'POST :create' do
      setup do
        post :create, vsp: FactoryGirl.attributes_for(:vsp)
      end

      should respond_with :redirect
      should redirect_to('public') { public_path }
    end

    context 'PATCH :update' do
      setup do
        @vsp = FactoryGirl.create :vsp
        patch :update, id: @vsp.id
      end
      should respond_with :redirect
      should redirect_to('public') { public_path }
    end

  end



end

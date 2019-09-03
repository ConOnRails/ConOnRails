# frozen_string_literal: true

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
          post :create, params: { vsp: { name: '' } }
        end
        should respond_with :success
        should render_template :new
        should_not set_flash.to(/created successfully!$/)
      end

      context 'correct attributes' do
        setup do
          post :create, params: { vsp: FactoryBot.attributes_for(:vsp) }
        end
        should respond_with :redirect
        should redirect_to('vsp list') { vsps_path }
        should set_flash.to(/created successfully!$/)
      end
    end

    context 'PATCH :update' do
      setup do
        @vsp = FactoryBot.create :vsp
      end

      context 'bad params' do
        setup do
          patch :update, params: { id: @vsp.id, vsp: { name: '' } }
        end
        should respond_with :success
        should render_template :edit
        should_not set_flash.to(/updated successfully!$/)
      end

      context 'good params' do
        setup do
          patch :update, params: { id: @vsp.id, vsp: { notes: 'Wombat' } }
        end

        should respond_with :redirect
        should redirect_to('vsp list') { vsps_path }
        should set_flash.to(/updated successfully!$/)
      end
    end

    context 'GET :edit' do
      setup do
        @vsp = FactoryBot.create :vsp
        get :edit, params: { id: @vsp.id }
      end

      should respond_with :success
      should render_template :edit
    end
  end

  user_context :typical_context do
    %i[index new edit].each do |x|
      context "GET #{x}" do
        setup do
          get x, params: { id: 42 }
        end
        should respond_with :redirect
        should redirect_to('root') { root_path }
      end
    end

    context 'POST :create' do
      setup do
        post :create
      end

      should respond_with :redirect
      should redirect_to('root') { root_path }
    end

    context 'PATCH :update' do
      setup do
        patch :update, params: { id: 42 }
      end
      should respond_with :redirect
      should redirect_to('root') { root_path }
    end
  end
end

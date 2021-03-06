# frozen_string_literal: true

require 'test_helper'

class ConventionsControllerTest < ActionController::TestCase
  setup do
    @convention = build :convention
  end

  user_context :admin_context do
    context 'should get index' do
      setup do
        get :index
      end

      should respond_with :success
    end

    context 'should get new' do
      setup do
        get :new
      end

      should respond_with :success
      should render_template :new
    end

    context 'should create convention' do
      setup do
        post :create, params: { convention: { end_date: @convention.end_date,
                                              name: @convention.name, start_date: @convention.start_date } }
      end

      should respond_with :redirect
      should redirect_to :conventions
    end

    context 'should show convention' do
      setup do
        @convention.save!
        get :show, params: { id: @convention }
      end

      should respond_with :success
      should render_template :show
    end

    context 'should get edit' do
      setup do
        @convention.save!
        get :edit, params: { id: @convention }
      end

      should respond_with :success
      should render_template :edit
    end

    context 'should update convention' do
      setup do
        @convention.save!
        put :update, params: { id: @convention,
                               convention: { end_date: @convention.end_date, name: @convention.name,
                                             start_date: @convention.start_date } }
      end

      should respond_with :redirect
      should redirect_to :conventions
    end
  end

  multiple_contexts :typical_context, :peon_context do
    context 'should get index' do
      setup do
        get :index
      end

      should respond_with :redirect
      should redirect_to :root
    end

    context 'should get new' do
      setup do
        get :new
      end

      should respond_with :redirect
      should redirect_to :root
    end

    context 'should create convention' do
      setup do
        post :create, params: { convention: { end_date: @convention.end_date,
                                              name: @convention.name, start_date: @convention.start_date } }
      end

      should respond_with :redirect
      should redirect_to :root
    end

    context 'should show convention' do
      setup do
        @convention.save!
        get :show, params: { id: @convention }
      end

      should respond_with :redirect
      should redirect_to :root
    end

    context 'should get edit' do
      setup do
        @convention.save!
        get :edit, params: { id: @convention }
      end

      should respond_with :redirect
      should redirect_to :root
    end

    context 'should update convention' do
      setup do
        @convention.save!
        put :update, params: { id: @convention,
                               convention: { end_date: @convention.end_date, name: @convention.name,
                                             start_date: @convention.start_date } }
      end

      should respond_with :redirect
      should redirect_to :root
    end
  end
end

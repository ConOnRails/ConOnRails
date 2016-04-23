require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  setup do
    @section = create :section
  end

  user_context :admin_context do
    context 'get #index' do
      setup do
        get :index
      end

      should respond_with :success
      should render_template :index
    end

    context 'get #show' do
      setup do
        get :show, id: @section.id
      end

      should respond_with :success
      should render_template :show
    end

    context 'get #new' do
      setup do
        get :new
      end

      should respond_with :success
      should render_template :new
    end

    context 'get #edit' do
      setup do
        get :edit, id: @section.id
      end

      should respond_with :success
      should render_template :edit
    end

    context 'post #create' do
      setup do
        post :create, section: { name: 'Doom' }
      end

      should respond_with :redirect
      should redirect_to('section') { section_path assigns(:section) }
    end

    context 'patch #update' do
      setup do
        patch :update, id: @section.id, section: { name: 'Doom' }
        @section.reload
      end

      should respond_with :redirect
      should redirect_to('section') { section_path @section }
    end

    context 'delete #destroy' do
      setup do
        delete :destroy, id: @section.id
      end

      should respond_with :redirect
      should redirect_to :sections
    end
  end

  multiple_contexts :typical_context, :peon_context do
    context 'get #index' do
      setup do
        get :index
      end

      should respond_with :redirect
      should redirect_to :public
    end

    context 'get #show' do
      setup do
        get :show, id: @section.id
      end

      should respond_with :redirect
      should redirect_to :public
    end

    context 'get #new' do
      setup do
        get :new
      end

      should respond_with :redirect
      should redirect_to :public
    end

    context 'get #edit' do
      setup do
        get :edit, id: @section.id
      end

      should respond_with :redirect
      should redirect_to :public
    end

    context 'post #create' do
      setup do
        post :create, section: { name: 'Doom' }
      end

      should respond_with :redirect
      should redirect_to :public
    end

    context 'patch #update' do
      setup do
        patch :update, id: @section.id, section: {}
      end

      should respond_with :redirect
      should redirect_to :public
    end

    context 'delete #destroy' do
      setup do
        delete :destroy, id: @section.id
      end

      should respond_with :redirect
      should redirect_to :public
    end
  end
end

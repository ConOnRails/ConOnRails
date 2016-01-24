# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  setup do
    @section = create :section
  end

  context 'Section management CRUD is based on can_admin_users?' do
    user_context :admin_context do
      context 'GET :index' do
        setup do
          get :index
        end

        should respond_with :success
        should render_template :index
        should 'have one section in the list' do
          assert_equal 1, assigns(:sections).count
        end
      end

      context 'GET :show' do
        setup do
          get :show, id: @section.id
        end

        should respond_with :success
        should render_template :show
      end

      context 'GET :new' do
        setup do
          get :new
        end

        should respond_with :success
        should render_template :new
      end

      context 'GET :edit' do
        setup do
          get :edit, id: @section.id
        end

        should respond_with :success
        should render_template :edit
      end

      context 'POST :create' do
        setup do
          post :create, section: { name: Faker::Name.name }
        end

        should respond_with :redirect
        should redirect_to('llama') { section_url assigns(:section) }
        should set_flash.to %r[created successfully]
      end

      context 'PATCH :update' do
        setup do
          patch :update, id: @section.id, section: { name: Faker::Name.name }
        end

        should respond_with :redirect
        should redirect_to('llama') { section_url assigns(:section) }
        should set_flash.to %r[updated successfully]
      end

      context 'PATCH update with related role assignments' do
        setup do
          @role = create :role, name: Faker::Name.first_name
          @role2 = create :role, name: Faker::Name.first_name
          patch :update, id: @section.id, section: { section_role: { @role.id => { read: 1, write: 1 }, @role2.id => { read_secure: 1 } }}
        end

        should 'set section roles up correctly' do
          section_roles = SectionRole.where section: @section, role: @role
          section_roles2 = SectionRole.where section: @section, role: @role2

          assert_equal 2, section_roles.count
          assert_equal 1, section_roles2.count
          assert_equal %w[read write], section_roles.pluck(:permission).sort
          assert_equal %w[read_secure], section_roles2.pluck(:permission).sort
        end
      end

      context 'PATCH update removes section roles that are unchecked' do
        setup do
          @role = create :role, name: Faker::Name.first_name
          @role2 = create :role, name: Faker::Name.first_name
          patch :update, id: @section.id, section: { section_role: { @role.id => { read: 1, write: 1 }, @role2.id => { read_secure: 1 } }}
        end
      end
    end


    user_context :typical_context do
      context 'GET :index' do
        setup do
          get :index
        end

        should respond_with :redirect
        should redirect_to :public
      end

      context 'GET :show' do
        setup do
          get :show, id: @section.id
        end

        should respond_with :redirect
        should redirect_to :public
      end

      context 'GET :new' do
        setup do
          get :new
        end

        should respond_with :redirect
        should redirect_to :public
      end

      context 'GET :edit' do
        setup do
          get :edit, id: @section.id
        end

        should respond_with :redirect
        should redirect_to :public
      end


      context 'POST create' do
        setup do
          post :create, section: { name: Faker::Name.name }
        end

        should respond_with :redirect
      end

      context 'PATCH update' do
        setup do
          patch :update, id: @section.id, section: {}
        end

        should respond_with :redirect
      end
    end
  end

end

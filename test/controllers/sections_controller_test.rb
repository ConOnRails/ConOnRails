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
        should redirect_to('llama') { edit_section_url(assigns(:section)) }
        should set_flash.to %r[updated successfully]
      end

      context 'PATCH update with related role assignments' do
        setup do
          @role = create :role, name: Faker::Name.first_name
          @role2 = create :role, name: Faker::Name.first_name
          patch :update, id: @section.id, section: { section_roles_attributes: { '0': { role_id: @role.id, read: 'true', write: 'true', secure: 'false' },
                                                                                 '1': { role_id: @role2.id, read: 'false', write: 'false', secure: 'true' } } }
        end

        should ' set section roles up correctly ' do
          section_role = SectionRole.find_by section: @section, role: @role
          section_role2 = SectionRole.find_by section: @section, role: @role2

          assert_not_nil section_role
          assert_not_nil section_role2
          assert section_role.read
          assert section_role.write
          assert section_role2.secure
        end
      end
    end


    user_context :typical_context do
      context ' GET : index ' do
        setup do
          get :index
        end

        should respond_with :redirect
        should redirect_to :public
      end

      context ' GET : show ' do
        setup do
          get :show, id: @section.id
        end

        should respond_with :redirect
        should redirect_to :public
      end

      context ' GET : new ' do
        setup do
          get :new
        end

        should respond_with :redirect
        should redirect_to :public
      end

      context ' GET : edit ' do
        setup do
          get :edit, id: @section.id
        end

        should respond_with :redirect
        should redirect_to :public
      end


      context ' POST create ' do
        setup do
          post :create, section: { name: Faker::Name.name }
        end

        should respond_with :redirect
      end

      context ' PATCH update ' do
        setup do
          patch :update, id: @section.id, section: {}
        end

        should respond_with :redirect
      end
    end
  end

end

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # TODO simplify admin permissions. They're currently much too granular for the real world.
    can :manage, Audit if user.can_read_audits?
    can :manage, Contact if user.can_admin_anything?
    can :manage, Convention if user.can_read_audits?
    can :manage, Department if user.can_admin_radios?
    can :manage, DutyBoardAssignment if user.can_assign_duty_board_slots?
    can :manage, DutyBoardGroup if user.can_admin_duty_board?
    can :manage, DutyBoardSlot if user.can_admin_duty_board?
    can :manage, LoginLog if user.can_read_audits?
    can :manage, LostAndFoundItem if user.can_admin_anything?
    can :manage, Message if user.persisted? # Just about anyone can fuck with messages. They're going away anyway
    can :manage, Radio if user.can_admin_radios?
    can :manage, RadioAssignment if user.can_assign_radios?
    can :manage, RadioAssignmentAudit if user.can_admin_radios?
    can :manage, RadioGroup if user.can_admin_radios?
    can :manage, Role if user.can_admin_users?
    can :manage, User if user.can_admin_users?
    can :manage, Version if user.can_read_audits?
    can :manage, Volunteer if user.can_admin_users?
    can :manage, Vsp if user.can_read_audits?

    can :read, Contact if user.persisted?
    can [:new, :create, :edit, :update], Contact if user.can_write_entries?
    can :read, Department if user.can_assign_radios?
    can :read, DutyBoardSlot if user.can_assign_duty_board_slots?
    can :update, DutyBoardSlot if user.persisted?
    can [:new, :create, :edit, :update, :merge_events], Event if user.can_write_entries?
    can [:read, :secure], Event, secure: true if user.can_read_secure?
    can :read, Event, hidden: true if user.can_read_hidden?
    can [:read, :sticky, :review, :tag, :search_entries], Event, secure: false if user.persisted?
    can [:new, :create], LostAndFoundItem if user.add_lost_and_found?
    can [:edit, :update], LostAndFoundItem if user.modify_lost_and_found?
    can [:read, :searchform], LostAndFoundItem if user.persisted?
    can [:index, :show, :search_volunteers], Radio if user.can_assign_radios?
    can [:index, :show], RadioGroup if user.can_assign_radios?
    can [:show, :update, :change_password], User, id: user.id

    # Define abilities for the passed in user here. For example:
    #
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

class Ability
  include CanCan::Ability

  EVENT_READ_ACTIONS = [:read, :review, :search_entries, :sticky, :tag]

  def initialize(user)
    user ||= User.new

    # Who can admin stuff
    can :manage, Contact if user.can_write_entries? # TODO: When we get real roles, fix this
    can :manage, Convention if user.can_read_audits? # TODO: When we get real roles, fix this
    can :manage, Department if user.can_admin_radios? # TODO: When we get real roles, fix this
    can :manage, DutyBoardAssignment if user.can_assign_duty_board_slots?
    can :manage, DutyBoardGroup if user.can_admin_duty_board?
    can :manage, DutyBoardSlot if user.can_admin_duty_board?
    can :manage, Message # Right now, just about any logged in person can do this.
    can :manage, Radio if user.can_admin_radios?
    can :manage, RadioAssignment if user.can_assign_radios?
    can :manage, RadioAssignmentAudit if user.can_admin_radios?
    can :manage, RadioGroup if user.can_admin_radios?
    can :manage, Role if user.can_admin_users?
    can :manage, Section if user.can_admin_users?
    can :manage, User if user.can_admin_users?
    can :manage, Version if user.can_read_audits?
    can :manage, Volunteer if user.can_admin_users?
    can :manage, Vsp if user.can_read_audits? # FIXME needs its own role

    # Other permissions
    can :read, Audit if user.can_read_audits?
    can :read, Department
    can :read, DutyBoardAssignment
    can :read, DutyBoardSlot
    can [:create, :update], Entry if user.can_write_entries?
    can [:create, :merge_items, :update], Event if user.can_write_entries?
    can :read, Entry
    can :secure, Event, secure: true if user.can_read_secure?
    can EVENT_READ_ACTIONS, Event, secure: false
    can :read, LoginLog if user.can_read_audits?
    can [:read, :create], LostAndFoundItem if user.add_lost_and_found?
    can [:read, :update], LostAndFoundItem if user.modify_lost_and_found?
    can :read, LostAndFoundItem
    can :read, RadioGroup if user.can_assign_radios?
    can [:read, :update], User, id: user.id

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
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

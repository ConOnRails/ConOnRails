class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Events and Entries nad Sections Oh My
    can :manage, Section if user.can_admin_users?
    can :read, Section, section_users: { user_id: user.id }

    can :manage, Event if user.can_admin_anything?
    # A user can read entries in any section they belong to. Complex query but the joins should sort it out I hope.
    can [:read, :sticky, :review, :tag, :search_entries], Event, event_sections: { section: { section_users: { user_id: user.id } } }

    # A user can create entries in any section at all if they belong to at least one section.
    can [:new, :create, :edit, :update, :merge_events], Event if user.sections.count > 0

   # cannot :index, Event unless user.persisted?

    can :read, EventSection, section: { section_users: { user_id: user.id } }

    # TODO simplify admin permissions. They're currently much too granular for the real world.
    can :manage, Audit if user.can_read_audits?
    can :manage, Contact if user.persisted?
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

    can :read, Department if user.can_assign_radios?
    can :read, DutyBoardSlot if user.can_assign_duty_board_slots?
    can :update, DutyBoardSlot if user.persisted?

    can [:new, :create], LostAndFoundItem if user.add_lost_and_found?
    can [:edit, :update], LostAndFoundItem if user.modify_lost_and_found?
    can [:read, :searchform], LostAndFoundItem if user.persisted?
    can [:index, :show, :search_volunteers], Radio if user.can_assign_radios?
    can [:index, :show], RadioGroup if user.can_assign_radios?
    can [:show, :update, :change_password], User, id: user.id
  end
end

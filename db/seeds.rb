# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(__dir__)
require 'factory_bot_rails'
require 'faker'

Convention.delete_all
Entry.delete_all
Event.delete_all
User.delete_all
Role.delete_all
LostAndFoundItem.delete_all
Radio.delete_all
RadioGroup.delete_all
RadioAssignment.delete_all
RadioAssignmentAudit.delete_all
Volunteer.delete_all
DutyBoardAssignment.delete_all
DutyBoardSlot.delete_all
DutyBoardGroup.delete_all

def create_events(user:, old: false)
  (0..25).each do |_i|
    base_time = rand(5.days.ago..Time.zone.now) - (old ? 1.year : 0)
    event = Event.create!(
      is_active: rand(1..6) != 6,
      hidden: rand(1..20) > 18,
      hotel: rand(1..4) == 4,
      created_at: base_time,
      updated_at: base_time
    )
    (0..rand(1..8)).each do |j|
      new_time = base_time + (j * 7).minutes
      Entry.create!(
        user: user,
        event: event,
        description: Faker::Lorem.paragraphs(number: 3).join("\n"),
        created_at: new_time,
        updated_at: new_time
      )

      EventFlagHistory.create!(
        event.attributes.reject do |k, _v|
          %w[merged_from_ids id alert_list corkboard_list].include? k
        end.merge(user: user, event: event)
      )
    end
  end
end


# Seed an admin user
user = User.create!(username: 'admin',
                    realname: 'Admin Droid',
                    password: 'controlthehorizontal',
                    password_confirmation: 'controlthehorizontal')
role = Role.create!(name: 'Head',
                    add_lost_and_found: true,
                    admin_duty_board: true,
                    admin_radios: true,
                    admin_schedule: true,
                    admin_users: true,
                    assign_duty_board_slots: true,
                    assign_radios: true,
                    assign_shifts: true,
                    modify_lost_and_found: true,
                    read_hidden_entries: true,
                    make_hidden_entries: true,
                    read_audits: true,
                    rw_secure: true,
                    write_entries: true)
user.roles << role
user.save!

# preseed the other roles.
# Since the db defaults these to false, we only need to specify what's true'
Role.create!(name: 'Subhead',
             add_lost_and_found: true,
             admin_duty_board: true,
             admin_radios: true,
             admin_schedule: true,
             admin_users: true,
             assign_duty_board_slots: true,
             assign_radios: true,
             assign_shifts: true,
             modify_lost_and_found: true,
             read_hidden_entries: true,
             make_hidden_entries: true,
             rw_secure: true,
             read_audits: true,
             write_entries: true)
Role.create!(name: 'XO',
             add_lost_and_found: true,
             admin_duty_board: true,
             admin_schedule: true,
             admin_users: true,
             assign_duty_board_slots: true,
             assign_radios: true,
             assign_shifts: true,
             modify_lost_and_found: true,
             write_entries: true)
Role.create!(name: 'First Contact',
             add_lost_and_found: true,
             modify_lost_and_found: true,
             write_entries: true)
Role.create!(name: 'Comm 1',
             add_lost_and_found: true,
             assign_duty_board_slots: true,
             modify_lost_and_found: true,
             write_entries: true)
Role.create!(name: 'Comm 2',
             add_lost_and_found: true,
             assign_duty_board_slots: true,
             modify_lost_and_found: true,
             write_entries: true)

dbg = DutyBoardGroup.create! name: 'Ops Leaders', row: 1, column: 1
DutyBoardSlot.create! name: 'Ops Head', duty_board_group: dbg
DutyBoardSlot.create! name: 'Ops Subhead1', duty_board_group: dbg
DutyBoardSlot.create! name: 'Ops Subhead2', duty_board_group: dbg

dbg = DutyBoardGroup.create! name: 'General Leadership', row: 1, column: 2
DutyBoardSlot.create! name: 'Exec On Duty', duty_board_group: dbg
DutyBoardSlot.create! name: 'Facilities', duty_board_group: dbg

dbg = DutyBoardGroup.create! name: 'On Bridge', row: 2, column: 1
DutyBoardSlot.create! name: 'XO', duty_board_group: dbg
DutyBoardSlot.create! name: 'Dispatch Officer', duty_board_group: dbg
DutyBoardSlot.create! name: 'Comm1 (Dispatch Logger)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Comm2 (General Logger)', duty_board_group: dbg
DutyBoardSlot.create! name: 'First Contact', duty_board_group: dbg
DutyBoardSlot.create! name: 'Gopher', duty_board_group: dbg

dbg = DutyBoardGroup.create! name: 'Wandering', row: 2, column: 2
DutyBoardSlot.create! name: 'Wandering Host 1 (Floating)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 2 (Parties)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 3 (North Tower)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 4 (South Tower)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 5 (Parties)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 6 (South Tower)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 7 (Floating)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 8 (Floating)', duty_board_group: dbg
DutyBoardSlot.create! name: 'Wandering Host 9 (Ethereal)', duty_board_group: dbg

#########

case Rails.env
when 'development'
  Audit.delete_all # Audit log has to be cleared by explicit act of god in production

  FactoryBot.create :radio_group, :when_red
  FactoryBot.create :radio_group, :when_black
  FactoryBot.create :radio_group, :when_green

  FactoryBot.create :many_blue_men_group
  FactoryBot.create :many_red_hands
  FactoryBot.create_list(:many_valid_volunteers, 42)

  User.create!(username: 'test', realname: 'Test User',
               password: 'testme', password_confirmation: 'testme')


  create_events user: user
  create_events user: user, old: true

  LostAndFoundItem.create!(
    user: user,
    category: 'Badges',
    reported_missing: true,
    where_last_seen: 'Wombatland',
    owner_name: 'Spike Spiegel',
    owner_contact: 'spike@bebop.co.mars',
    description: '#4242',
    details: 'I am the walrus'
  )

  LostAndFoundItem.create!(
    user: user,
    category: 'Weapons/Props',
    found: true,
    where_found: 'Atrium 42',
    description: "A frickin' laser",
    details: "One laser, frickin'"
  )

  Convention.create!(
    name: 'TestConvention',
    start_date: 10.days.ago,
    end_date: 90.days.from_now,
    created_at: 16.days.ago,
    updated_at: 16.days.ago
  )

  Convention.create!(
    name: "Last Year's Con",
    start_date: 375.days.ago,
    end_date: 285.days.ago,
    created_at: 380.days.ago,
    updated_at: 380.days.ago
  )

end

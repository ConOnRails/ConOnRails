# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
$LOAD_PATH.unshift File.expand_path('..', __FILE__)
require 'factory_girl_rails'
require 'faker'

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

if $RAILS_ENV == 'development'
  Factory :many_blue_men_group
  Factory :many_red_hands
  llama = FactoryGirl.create_list(:many_valid_volunteers, 42)
end

# Seed an admin user
user = User.create!({ name:                  "admin",
                      realname:              "Admin Droid",
                      password:              "controlthehorizontal",
                      password_confirmation: "controlthehorizontal"
                    })

role = Role.create!({ name:                    "Head",
                      add_lost_and_found:      true,
                      admin_duty_board:        true,
                      admin_radios:            true,
                      admin_schedule:          true,
                      admin_users:             true,
                      assign_duty_board_slots: true,
                      assign_radios:           true,
                      assign_shifts:           true,
                      modify_lost_and_found:   true,
                      read_hidden_entries:     true,
                      make_hidden_entries:     true,
                      rw_secure:               true,
                      write_entries:           true
                    })
user.roles << role
user.save!

# preseed the other roles. Since the db defaults these to false, we only need to specify what's true'
Role.create!({ name:                    "Subhead",
               add_lost_and_found:      true,
               admin_duty_board:        true,
               admin_radios:            true,
               admin_schedule:          true,
               admin_users:             true,
               assign_duty_board_slots: true,
               assign_radios:           true,
               assign_shifts:           true,
               modify_lost_and_found:   true,
               read_hidden_entries:     true,
               make_hidden_entries:     true,
               rw_secure:               true,
               write_entries:           true
             })
Role.create!({ name:                    "XO",
               add_lost_and_found:      true,
               admin_duty_board:        true,
               admin_schedule:          true,
               admin_users:             true,
               assign_duty_board_slots: true,
               assign_radios:           true,
               assign_shifts:           true,
               modify_lost_and_found:   true,
               write_entries:           true
             })
Role.create!({ name:                  "First Contact",
               add_lost_and_found:    true,
               modify_lost_and_found: true,
               write_entries:         true
             })
Role.create!({ name:                    "Comm 1",
               add_lost_and_found:      true,
               assign_duty_board_slots: true,
               modify_lost_and_found:   true,
               write_entries:           true })
Role.create!({ name:                    "Comm 2",
               add_lost_and_found:      true,
               assign_duty_board_slots: true,
               modify_lost_and_found:   true,
               write_entries:           true })

User.create!({ name:     "test", realname: "Test User",
               password: "testme", password_confirmation: "testme" })

(0..25).each do |i|
  event = Event.create!(
      {
          is_active: rand(1..6) == 6 ? false : true,
          hidden:    rand(1..20) > 18 ? true : false
      }
  )
  (0..rand(1..8)).each do |j|
    Entry.create!(
        {
            user:        user,
            event:       event,
            description: Faker::Lorem.paragraphs(3)
        }
    )
  end
end


LostAndFoundItem.create!(
    {
        category:         "Badge",
        reported_missing: true,
        where_last_seen:  "Wombatland",
        owner_name:       "Spike Spiegel",
        owner_contact:    "spike@bebop.co.mars",
        description:      "#4242",
        details:          "I am the walrus"
    }
)

LostAndFoundItem.create!(
    {
        category:    "Weapon",
        found:       true,
        where_found: "Atrium 42",
        description: "A frickin' laser",
        details:     "One laser, frickin'"
    }
)

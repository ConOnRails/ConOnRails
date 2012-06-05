FactoryGirl.define do
  factory :radio_group, class: RadioGroup do
    factory :blue_man_group do
      name "Blue"
      color "blue"
      notes "Blue!"

      factory :many_blue_men_group do
        after :create do |group, eval|
          FactoryGirl.create_list(:one_of_many_blue_radios, 42, radio_group: group)
        end
      end
    end

    factory :red_handed do
      name "Red"
      color "red"
      notes "RED!!!!!!"

      factory :many_red_hands do
        after :create do |group, eval|
          FactoryGirl.create_list(:one_of_many_red_radios, 14, radio_group: group)
        end
      end
    end
  end

  factory :radio do
    state "in"

    factory :valid_blue_radio do
      number "42"
      association :radio_group, factory: :blue_man_group
    end
    factory :one_of_many_blue_radios do
      sequence :number do |n|
        "Q#{n}"
      end
    end
    factory :one_of_many_red_radios do
      sequence :number do |n|
        "R#{n}"
      end
    end
  end

  factory :radio_assignment do
    factory :valid_radio_assignment do
      association :radio, factory: :valid_blue_radio
      association :volunteer, factory: :valid_volunteer
      association :department, factory: :good_department
    end
  end

  factory :message do
    factory :valid_message do
      self.for "Someone"
      phone_number "666-666-6666"
      message "Watch out for wombats"

      factory :valid_message_with_user do
        association :user, factory: :peon
      end

    end

  end

  factory :volunteer do
    factory :valid_volunteer do
      first_name "Rufus"
      middle_name "Xavier"
      last_name "Sassparilla"
      address1 "666 Sixth Street SE"
      home_phone "+1 666-666-6666"
      email "rxs@rxs.nowhere"
      association :volunteer_training, factory: :valid_volunteer_training
    end

    factory :many_valid_volunteers do
      sequence :first_name do |n|
        "Wombat#{n}"
      end
      sequence :last_name do |n|
        "Feathers#{n}"
      end
      sequence :address1 do |n|
        "#{n} East #{n} Street"
      end
      sequence(:home_phone) { |n| "+1 666-666-" + Kernel.sprintf("%04d", n) }
      sequence :email do |n|
        "yak#{n}@yak.yk"
      end
      association :volunteer_training, factory: :valid_volunteer_training
    end
  end

  factory :volunteer_training do

    factory :valid_volunteer_training do
      radio true
      communications true
    end
  end

  factory :contact do
  end

  factory :valid_contact, class: Contact do
    name "Wom Bat"
    department "Lingerie"
    cell_phone "+1 123 456 7890"
    hotel "Ritz"
    hotel_room 666
  end

  factory :user do
    name "wombat"
    realname "Wom Bat"
    password "batwom"
  end

  factory :peon, class: User do
    name "peon"
    realname "Peon"
    password "peon69"
  end

  factory :dummy_user, class: User do
    name "dummy"
    realname "Dummy"
    password "dummy42"
  end

  factory :other_dummy_user, class: User do
    name "ymmud"
    realname "Ymmud"
    password "24ymmud"
  end

  factory :role do
    name "peon"

    factory :admin_users_role do
      name "admin_users"
      admin_users true
    end

    factory :write_entries_role do
      name "write_entries"
      write_entries true
    end

    factory :read_hidden_entries_role do
      name "read_hidden_entries"
      read_hidden_entries true
    end

    factory :make_hidden_entries_role do
      name "make_hidden_entries"
      make_hidden_entries true
    end
    factory :rw_secure_role do
      name "rw_secure"
      rw_secure true
    end

    factory :can_admin_lost_and_found_user do
      name "can_admin_lost_and_found"
      add_lost_and_found true
      modify_lost_and_found true
    end

    factory :assign_radios_role do
      name "can_assign_radios"
      assign_radios true

      factory :admin_radios_role do
        name "can_admin_radios"
        admin_radios true
      end
    end
  end

  factory :event do
    is_active true

    factory :ordinary_event do
      hidden false

      after :create do |event, evaluator|
        entry = FactoryGirl.build :oneliner_entry, event: event, user: FactoryGirl.create(:dummy_user)
      end
    end

    factory :hidden_event do
      hidden true

      after :create do |event, evaluator|
        entry = FactoryGirl.build :verbose_entry, event: event, user: FactoryGirl.create(:other_dummy_user)
      end
    end
  end

  factory :entry do
#    user FactoryGirl.create :dummy_user

    factory :oneliner_entry do
      description "MyText is full of llama meat llama meat llama meat"
    end

    factory :verbose_entry do
      description "" "
      Kimi o ai no
      Aishiteta to nageku ni wa
      Amari ni mo toki  wa sugi te shimatta
      Mada kokoro no hokorobi o
      Iyasenumama kaze ga fuiteru

      Hitotsu no me de asu o mite
      Hitotsu no me de kinou mitsumeteru
      Kimi no ai no yurikagode
      Mo ichido yasurakani nemuretara

      Kawaita hitomi de dareka na itekure

      The real folk blues
      Honto no kanashimi ga shiritaidake
      Doro no kawa ni sukatta jinsei mo warukuwanai
      Ichido kiri de owarunara

      Kibou ni michita zetsuboto
      Wanagashikakerareteru kono chansu
      Nani ga yoku te warui no ka
      Koin no omoi to kuramitaita

      Dore dake ikireba iyasareru no darou

      The real folk blues
      Honto no yorokobi ga shiritai dake
      Hikaru mono no subete ga ougen to wa kagiranai
      The real folk blues
      Honto no kanashimi ga shiritaidake
      Doro no kawa ni sukatta jinsei mo warukuwanai
      Ichido kiri de owarunara
      " ""
    end
  end

  factory :lost_and_found_item do
    factory :incomplete

    factory :lost do
      reported_missing true
      category "Badge"
      description "Llamas and Tigers and Bears"
      where_last_seen "MyString"
      owner_name "MyString"
    end

    factory :found do
      found true
      description "Wombats and Llamas and Snakes"
      category "Badge"
      where_found "MyString"
      owner_name "MyString"
      owner_contact "MyText"
    end

    factory :returned do
      found true
      reported_missing true
      returned true
      category "Badge"
      description "Emus, Begonias and Flakes"
      where_found "MyString"
      owner_name "MyString"
      owner_contact "MyText"
    end
  end

  factory :department do
    factory :good_department do
      name "Operations"
      radio_allotment 1
      association :radio_group, factory: :blue_man_group
      association :volunteer, factory: :valid_volunteer
    end

    factory :one_too_many do
      name "Doom"
      radio_allotment 1 # but the blue_man group only has one, so if this and good_department are defined, the second should fail
      association :radio_group, factory: :blue_man_group
      association :volunteer, factory: :valid_volunteer
    end
  end


end



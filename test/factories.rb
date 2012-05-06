FactoryGirl.define do
  factory :message do
    factory :valid_message do
      self.for "Someone"
      phone_number "666-666-6666"
      message "Watch out for wombats"

      factory :valid_message_with_user do
        before_create do |message, eval|
          message.user = FactoryGirl.create :peon
        end
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

      after_create do |vol, evaluator|
        volunteer_training     = FactoryGirl.build :valid_volunteer_training, volunteer: vol
        vol.volunteer_training = volunteer_training
      end

      after_build do |vol, evaluator|
        volunteer_training     = FactoryGirl.build :valid_volunteer_training, volunteer: vol
        vol.volunteer_training = volunteer_training
      end

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

    factory :can_admin_lost_and_found_user do
      name "can_admin_lost_and_found"
      add_lost_and_found true
      modify_lost_and_found true
    end

  end

  factory :event do
    is_active true

    factory :ordinary_event do
      hidden false

      after_create do |event, evaluator|
        entry = FactoryGirl.build :oneliner_entry, event: event, user: FactoryGirl.create(:dummy_user)
      end
    end

    factory :hidden_event do
      hidden true

      after_create do |event, evaluator|
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
end



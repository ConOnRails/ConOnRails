# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Entry.delete_all
Event.delete_all
User.delete_all
LostAndFoundItem.delete_all

user = User.create!( { name: "mikey",
  realname: "Michael Scott Shappe",
  password: "zogity",
  password_confirmation: "zogity"
  } )

event = Event.create!( 
  {} )

Entry.create!( 
  { user: user,
    event: event,
    description: 
          %{
            Never let the llamas loose.
            Never ever ever.
            Never let the llamas loose.
            Even wearing leather.
            } } )
Entry.create!( 
  { user: user,
    event: event,
    description:
              %{
                Kawaita hitome de
                Dare katma itekure
                The real folk blues
                Honto no kana shimi ga
                Shiritaidake
                } } )

LostAndFoundItem.create!(
  {
    category: "Badge",
    reported_missing: true,
    where_last_seen: "Wombatland",
    owner_name: "Spike Spiegel",
    owner_contact: "spike@bebop.co.mars",
    description: "#4242",
    details: "I am the walrus"
  }
  )
  
LostAndFoundItem.create!(
  {
    category: "Weapon",
    found: true,
    where_found: "Atrium 42",
    description: "A frickin' laser",
    details: "One laser, frickin'"
  }
  )
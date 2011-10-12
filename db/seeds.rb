# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Entry.delete_all
Event.delete_all
EventStatus.delete_all
EventType.delete_all
User.delete_all

user = User.create( { handle: "Uncle Mikey",
                        name: "Michael Scott Shappe"
                    } )
                 
                   

statuses = EventStatus.create( [ { tag: 'active', name: 'Active' },
                                 { tag: 'dup', name: 'Duplicate' },
                                 { tag: 'resolved', name: 'Resolved' }
                               ] )
types = EventType.create( [ { tag: 'general', name: 'General' },
                            { tag: 'emerg', name: 'Emergency' },
                            { tag: 'med', name: 'Medical' },
                            { tag: 'followup', name: 'Post Con Followup' },
                            { tag: 'quote', name: 'Quote' }
                          ] )

p statuses
event_status = statuses[0]
event_type = types[0]

event = Event.create( { summary: "Sit right down and hear a tale of a fateful trip",
                          event_status: event_status,
                          event_type: event_type
                      } )

Entry.create( { user: user,
                  event: event,
                  description: 
                  %{
Never let the llamas loose.
Never ever ever.
Never let the llamas loose.
Even wearing leather.
} } )
Entry.create( {
                  user: user,
                  event: event,
                  description:
                  %{
Kawaita hitome de
Dare katma itekure
The real folk blues
Honto no kana shimi ga
Shiritaidake
} } )


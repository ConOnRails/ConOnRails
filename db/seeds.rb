# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Entry.delete_all

Entry.create(description: 
	%{<p>
		Never let the llamas loose.
		Never ever ever.
		Never let the llamas loose.
		Even wearing leather.
	</p>})
Entry.create(description:
             %{
Kawaita hitome de
Dare katma itekure
The real folk blues
Honto no kana shimi ga
Shiritaidake
})

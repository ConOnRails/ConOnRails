# Adding this here instead of a seed file since this needs to be applied to an existing prod db 
# (and seeds.rb wouldn't be run in that environment)
class SeedLostAndFoundCategories < ActiveRecord::Migration
  def up
  	LostAndFoundCategory.create(name:"Badges")
  	LostAndFoundCategory.create(name:"Bags")
  	LostAndFoundCategory.create(name:"Bottles")
  	LostAndFoundCategory.create(name:"Clothing")
  	LostAndFoundCategory.create(name:"Costume Jewelry")
  	LostAndFoundCategory.create(name:"Electronics")
  	LostAndFoundCategory.create(name:"Glasses")
  	LostAndFoundCategory.create(name:"Headgear")
  	LostAndFoundCategory.create(name:"Jewelry")
  	LostAndFoundCategory.create(name:"Keys")
  	LostAndFoundCategory.create(name:"Media")
  	LostAndFoundCategory.create(name:"Money/Cards/ID")
  	LostAndFoundCategory.create(name:"Paper (incl. Reg Packets)")
  	LostAndFoundCategory.create(name:"Small Electronics")
  	LostAndFoundCategory.create(name:"Toys")
  	LostAndFoundCategory.create(name:"Wallet")
  	LostAndFoundCategory.create(name:"Weapons/Props")
  	LostAndFoundCategory.create(name:"Other Not Listed")
  end

  def down
  	LostAndFoundCategory.delete_all
  end

end
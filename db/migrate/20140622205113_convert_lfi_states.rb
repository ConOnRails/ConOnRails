# frozen_string_literal: true

class ConvertLfiStates < ActiveRecord::Migration[4.2]
  def up
    LostAndFoundItem.all.each do |lfi|
      if lfi[:reported_missing]
        p "#{lfi.id} missing"
        lfi.lost_and_found_state_list.add('reported_missing')
      end

      if lfi[:found]
        p "#{lfi.id} found"
        lfi.lost_and_found_state_list.add('found')
      end

      if lfi[:returned]
        p "#{lfi.id} returned"
        lfi.lost_and_found_state_list.add('returned')
      end
      p lfi.category
      lfi.save(validate: false)
    end
  end

  def down
    LostAndFoundItem.all.each do |lfi|
      lfi[:reported_missing] = lfi.lost_and_found_state_list.include? 'reported_missing'
      lfi[:found] = lfi.lost_and_found_state_list.include? 'found'
      lfi[:returned] = lfi.lost_and_found_state_list.include? 'returned'
      lfi.save(validate: false)
    end
  end
end

require 'csv'

def flags(event)
  event.event_flag_histories.collect do |efh|
    "at #{efh.created_at.getlocal.ctime} by #{efh.user.realname} as #{efh.rolename}\r  " +
      Event.flags.collect do |f|
        if f == 'is_active' && efh[f] == false
          'CLOSED'
        elsif efh[f] == true
          "#{f}"
        end
      end.compact.join(' ') +
      efh.alert_list.collect do |f|
        "#{f}"
      end.compact.join(' ')
  end.join("\r")
end

def entries(event)
  first = event.entries.first
  event.entries.collect do |entry|
    created_or_updated = (entry == first) ? 'created' : 'update'
    "#{entry.created_at.getlocal.ctime} #{created_or_updated} by #{entry.user.realname} as #{entry.rolename}\r#{entry.description}"
  end.join("\r\r")
end

cons = Convention.order(:start_date).to_a
con_index = -1

loop do
  puts 'Pick a con'
  cons.each_with_index { |c, i| puts "#{i + 1} #{c.name}" }
  con_index = gets.to_i - 1
  break if con_index >= 0 && con_index < cons.size
end

con = cons[con_index]
filename = "#{con.name.downcase.gsub(' ', '_')}-event-log.csv"

CSV.open filename, 'wb', headers: :first do |csv|
  csv << ['ID', 'State', 'Flag History', 'Entries']
  Event.where { |e| (e.created_at >= con.start_date) & (e.created_at <= con.end_date) }
       .order('created_at').each do |event|
    csv << [
      event.id,
      event.status,
      flags(event),
      entries(event)
    ]
  end
end

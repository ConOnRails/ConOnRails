require 'csv'

namespace :stuff do
  desc "Import contacts from a CSV file"
  task :import_contacts => :environment do
    CSV.foreach ENV["FILE"] do |row|
      Contact.new(department: row[0],
                  name: row[1],
                  position: row[2],
                  cell_phone: row[3],
                  can_text: row[4] == "Yes" ? true : false) do |contact|
        contact.save!
      end
    end
  end
end

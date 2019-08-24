# frozen_string_literal: true

require 'csv'

CSV.open 'volunteer-report.csv', 'wb' do |csv|
  csv << ['Name', 'Home', 'Other', 'Email', 'Radio',
          'Basics', '1st Contact', 'Comm', 'Dispatch',
          'Wandering', 'XO', 'Ops SubHead', 'Ops Head']
  Volunteer.includes(:volunteer_training).each do |v|
    csv << [v.name, v.home_phone, v.other_phone, v.email,
            v.volunteer_training.radio?,
            v.volunteer_training.ops_basics?,
            v.volunteer_training.first_contact?,
            v.volunteer_training.communications?,
            v.volunteer_training.dispatch?,
            v.volunteer_training.wandering_host?,
            v.volunteer_training.xo?,
            v.volunteer_training.ops_subhead?,
            v.volunteer_training.ops_head?]
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: event_flag_histories
#
#  id                          :integer          not null, primary key
#  accessibility_and_inclusion :boolean          default("false")
#  allocations                 :boolean          default("false")
#  consuite                    :boolean          default("false")
#  dealers                     :boolean          default("false")
#  dock                        :boolean          default("false")
#  emergency                   :boolean          default("false")
#  first_advisors              :boolean          default("false")
#  hidden                      :boolean          default("false")
#  hotel                       :boolean          default("false")
#  is_active                   :boolean          default("false")
#  medical                     :boolean          default("false")
#  member_advocates            :boolean          default("false")
#  merchandise                 :boolean          default("false")
#  merged                      :boolean
#  nerf_herders                :boolean          default("false")
#  operations                  :boolean          default("false")
#  orig_time                   :datetime
#  parties                     :boolean          default("false")
#  post_con                    :boolean          default("false")
#  programming                 :boolean          default("false")
#  registration                :boolean          default("false")
#  rolename                    :string
#  secure                      :boolean          default("false")
#  smokers_paradise            :boolean          default("false")
#  sticky                      :boolean          default("false")
#  volunteers                  :boolean          default("false")
#  volunteers_den              :boolean          default("false")
#  created_at                  :datetime
#  updated_at                  :datetime
#  event_id                    :integer
#  user_id                     :integer
#
# Indexes
#
#  index_event_flag_histories_on_created_at  (created_at)
#  index_event_flag_histories_on_event_id    (event_id)
#  index_event_flag_histories_on_updated_at  (updated_at)
#

class EventFlagHistory < ApplicationRecord
  include AlertTags

  has_paper_trail

  belongs_to :event
  belongs_to :user

  def status=(string)
    raise StandardError if (string != 'Active') && (string != 'Closed')

    self.is_active = true if string == 'Active'
    self.is_active = false if string == 'Closed'
  end
end

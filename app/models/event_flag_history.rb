# frozen_string_literal: true

# == Schema Information
#
# Table name: event_flag_histories
#
#  id                          :integer          not null, primary key
#  accessibility_and_inclusion :boolean          default(FALSE)
#  allocations                 :boolean          default(FALSE)
#  consuite                    :boolean          default(FALSE)
#  dealers                     :boolean          default(FALSE)
#  dock                        :boolean          default(FALSE)
#  emergency                   :boolean          default(FALSE)
#  first_advisors              :boolean          default(FALSE)
#  hidden                      :boolean          default(FALSE)
#  hotel                       :boolean          default(FALSE)
#  is_active                   :boolean          default(FALSE)
#  medical                     :boolean          default(FALSE)
#  member_advocates            :boolean          default(FALSE)
#  merchandise                 :boolean          default(FALSE)
#  merged                      :boolean
#  nerf_herders                :boolean          default(FALSE)
#  operations                  :boolean          default(FALSE)
#  orig_time                   :datetime
#  parties                     :boolean          default(FALSE)
#  post_con                    :boolean          default(FALSE)
#  programming                 :boolean          default(FALSE)
#  registration                :boolean          default(FALSE)
#  rolename                    :string
#  secure                      :boolean          default(FALSE)
#  smokers_paradise            :boolean          default(FALSE)
#  sticky                      :boolean          default(FALSE)
#  volunteers                  :boolean          default(FALSE)
#  volunteers_den              :boolean          default(FALSE)
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
    raise Exception if (string != 'Active') && (string != 'Closed')

    self.is_active = true if string == 'Active'
    self.is_active = false if string == 'Closed'
  end
end

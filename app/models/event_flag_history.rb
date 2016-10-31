# == Schema Information
#
# Table name: event_flag_histories
#
#  id           :integer          not null, primary key
#  event_id     :integer
#  is_active    :boolean          default(FALSE)
#  post_con     :boolean          default(FALSE)
#  sticky       :boolean          default(FALSE)
#  emergency    :boolean          default(FALSE)
#  medical      :boolean          default(FALSE)
#  hidden       :boolean          default(FALSE)
#  secure       :boolean          default(FALSE)
#  consuite     :boolean          default(FALSE)
#  hotel        :boolean          default(FALSE)
#  parties      :boolean          default(FALSE)
#  volunteers   :boolean          default(FALSE)
#  dealers      :boolean          default(FALSE)
#  dock         :boolean          default(FALSE)
#  merchandise  :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  orig_time    :datetime
#  rolename     :string
#  merged       :boolean
#  nerf_herders :boolean          default(FALSE)
#

class EventFlagHistory < ActiveRecord::Base
  include AlertTags

  has_paper_trail

  belongs_to :event
  belongs_to :user

  def status=(string)
    raise Exception if string != 'Active' and string != 'Closed'
    self.is_active = true if string == 'Active'
    self.is_active = false if string == 'Closed'
  end
end


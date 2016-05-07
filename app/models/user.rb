# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  realname        :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_paper_trail

  paginates_per 25

  has_one :volunteer
  has_and_belongs_to_many :roles

  has_many :section_users
  has_many :sections, through: :section_users

  name_regex = /\A[a-zA-Z0-9_\-]*\z/
  password_regex = /\A[a-zA-Z0-9!@#$\%^&*()\-_ ]*\z/

  validates :username, presence: true,
            allow_blank: false,
            uniqueness: true,
            length: { maximum: 32 },
            format: { with: name_regex }
  validates :realname, presence: true,
            allow_blank: true,
            length: { maximum: 64 }
  has_secure_password
  validates :password, on: :create,
            presence: true,
            length: { within: 6..32 },
            format: { with: password_regex }

  scope :by_username,  -> { order(:username) }
  
  def find_perm(perm)
    ret = false
    roles.each do |role|
      if role.send(perm)
        ret = true
      end
    end
    return ret
  end

  def can_read_section?(section)
    sections.include? section
  end

  def can_admin_anything?
    return (find_perm "admin_users?" or
        find_perm "admin_duty_board?" or
        find_perm "admin_radios?")
  end

  def can_admin_users?
    find_perm "admin_users?"
  end

  def add_lost_and_found?
    find_perm "add_lost_and_found?"
  end

  def modify_lost_and_found?
    find_perm "modify_lost_and_found?"
  end

  def can_assign_radios?
    find_perm "assign_radios"
  end

  def can_admin_radios?
    find_perm "admin_radios"
  end

  def can_admin_duty_board?
    find_perm "admin_duty_board"
  end

  def can_assign_duty_board_slots?
    find_perm "assign_duty_board_slots"
  end

  def can_read_audits?
    find_perm "read_audits"
  end

  def has_role?(*role_names)
    self.roles.where(name: role_names).any?
  end
end

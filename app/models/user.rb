# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  realname        :string
#  username        :string
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#

class User < ApplicationRecord
  has_paper_trail

  paginates_per 25

  has_one :volunteer, dependent: :destroy
  has_and_belongs_to_many :roles # rubocop:disable Rails/HasAndBelongsToMany

  name_regex = /\A[a-zA-Z0-9_\-]*\z/
  password_regex = /\A[a-zA-Z0-9!@#{$OUTPUT_RECORD_SEPARATOR}%^&*()\-_ ]*\z/

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
      ret = true if role.send(perm)
    end
    ret
  end

  def can_admin_anything?
    (find_perm('admin_users?') ||
        find_perm('admin_schedule?') ||
        find_perm('admin_duty_board?') ||
        find_perm('admin_radios?'))
  end

  def can_admin_users?
    find_perm 'admin_users?'
  end

  def write_entries?
    find_perm 'write_entries?'
  end

  alias can_write_entries? write_entries?

  def read_hidden_entries?
    find_perm 'read_hidden_entries?'
  end

  alias can_read_hidden? read_hidden_entries?

  def add_lost_and_found?
    find_perm 'add_lost_and_found?'
  end

  def modify_lost_and_found?
    find_perm 'modify_lost_and_found?'
  end

  def can_assign_radios?
    find_perm 'assign_radios'
  end

  def can_admin_radios?
    find_perm 'admin_radios'
  end

  def can_make_hidden_entries?
    find_perm 'make_hidden_entries?'
  end

  def can_admin_duty_board?
    find_perm 'admin_duty_board'
  end

  def can_assign_duty_board_slots?
    find_perm 'assign_duty_board_slots'
  end

  def can_read_audits?
    find_perm 'read_audits'
  end

  def rw_secure?
    find_perm 'rw_secure?'
  end

  alias can_read_secure? rw_secure?

  def role?(*role_names)
    roles.where(name: role_names).any?
  end
end

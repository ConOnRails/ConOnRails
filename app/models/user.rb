# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  realname        :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_paper_trail

  paginates_per 25

  has_one :volunteer
  has_and_belongs_to_many :roles

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

  scope :by_username, -> { order(:username) }

  def role_names
    roles.pluck(:name)
  end

  def find_perm(perm)
    ret = false
    roles.each do |role|
      if role.send(perm)
        ret = true
      end
    end
    return ret
  end

  # NEW SECTION PERMISSIONS. New system. New and improved! All new! Shinier and more absorbent!
  def method_missing(name, *args, &block)
    if name.to_s =~ %r[can_(read|write|secure)_section\??]
      SectionRole.where(section: args.first, role: self.roles).where('permission_flags @> ?', { $1 => true }.to_json).present?
    else
      super
    end
  end

  def respond_to?(name, include_private = false)
    if name =~ %r[can_(read|write|secure)_section\??]
      true
    else
      super
    end
  end

  def can_admin_anything?
    return (find_perm "admin_users?" or
        find_perm "admin_schedule?" or
        find_perm "admin_duty_board?" or
        find_perm "admin_radios?")
  end

  def can_admin_users?
    find_perm "admin_users?"
  end

  def write_entries?
    find_perm "write_entries?"
  end

  alias :can_write_entries? :write_entries?

  def read_hidden_entries?
    find_perm "read_hidden_entries?"
  end

  alias :can_read_hidden? :read_hidden_entries?

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

  def can_make_hidden_entries?
    find_perm "make_hidden_entries?"
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

  def rw_secure?
    find_perm "rw_secure?"
  end

  alias :can_read_secure? :rw_secure?

  def has_role?(*role_names)
    self.roles.where(name: role_names).any?
  end
end

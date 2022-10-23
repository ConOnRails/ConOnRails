# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id                      :integer          not null, primary key
#  add_lost_and_found      :boolean
#  admin_duty_board        :boolean
#  admin_radios            :boolean
#  admin_schedule          :boolean
#  admin_users             :boolean
#  assign_duty_board_slots :boolean
#  assign_radios           :boolean
#  assign_shifts           :boolean
#  make_hidden_entries     :boolean          default("false")
#  modify_lost_and_found   :boolean
#  name                    :string
#  read_audits             :boolean          default("false")
#  read_hidden_entries     :boolean
#  rw_secure               :boolean          default("false")
#  write_entries           :boolean
#  created_at              :datetime
#  updated_at              :datetime
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#

class Role < ApplicationRecord
  has_paper_trail

  has_and_belongs_to_many :users # rubocop:disable Rails/HasAndBelongsToMany

  name_regex = /\A[a-zA-Z0-9_ ]*\z/

  validates :name, presence: true,
                   allow_blank: false,
                   uniqueness: true,
                   length: { maximum: 32 },
                   format: { with: name_regex }
end

# frozen_string_literal: true

class Timesheet < ApplicationRecord
  belongs_to :user
  has_many :time_entries, dependent: :restrict_with_error, inverse_of: :timesheet

  accepts_nested_attributes_for :time_entries, reject_if: :all_blank, allow_destroy: true

  validates :start, presence: true
  validates :end, presence: true
end

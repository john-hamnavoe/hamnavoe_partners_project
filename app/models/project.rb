# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :issues, dependent: :restrict_with_error
  has_many :tickets, dependent: :restrict_with_error
end

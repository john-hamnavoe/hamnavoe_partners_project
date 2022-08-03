class TestCase < ApplicationRecord
  belongs_to :project

  has_many :cases, dependent: :restrict_with_error

  has_many :active_cases, -> { active }, class_name: "Case", dependent: :restrict_with_error
  has_many :blocking_p1_cases, -> { blocking_p1 }, class_name: "Case", dependent: :restrict_with_error
  has_many :blocking_p2_cases, -> { blocking_p2 }, class_name: "Case", dependent: :restrict_with_error
end

class TestCase < ApplicationRecord
  belongs_to :project

  has_many :cases, dependent: :restrict_with_error

  has_many :active_cases, -> { active }, class_name: "Case", dependent: :restrict_with_error
end

class TestCase < ApplicationRecord
  belongs_to :project

  has_many :cases, dependent: :restrict_with_error
end

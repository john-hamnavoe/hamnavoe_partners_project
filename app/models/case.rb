class Case < ApplicationRecord
  belongs_to :project
  belongs_to :test_case, optional: true
end

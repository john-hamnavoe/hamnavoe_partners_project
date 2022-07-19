class Case < ApplicationRecord
  belongs_to :project
  belongs_to :test_case, optional: true

  scope :active, -> { where("status != 'Closed'").order(:case_no) }
end

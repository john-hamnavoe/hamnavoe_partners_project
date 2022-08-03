class Case < ApplicationRecord
  belongs_to :project
  belongs_to :test_case, optional: true

  scope :active, -> { where("status != 'Closed'").order(:case_no) }
  scope :blocking_p1, -> { where("status != 'Closed' AND status != 'With Customer' AND priority = 'Priority 1'").order(:case_no) }
  scope :blocking_p2, -> { where("status != 'Closed' AND status != 'With Customer' AND priority = 'Priority 2'").order(:case_no) }
end

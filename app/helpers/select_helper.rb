# frozen_string_literal: true

module SelectHelper
  def test_case_for_select
    TestCase.where(project: Project.first).order(:position).map { |test_case| ["#{test_case.position}. #{test_case.title}", test_case.id] }
  end
end



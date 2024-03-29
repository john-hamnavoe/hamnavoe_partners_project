# frozen_string_literal: true

class TestCaseReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances include CableReady::Broadcaster and expose the following properties:
  #
  #   - connection  - the ActionCable connection
  #   - channel     - the ActionCable channel
  #   - request     - an ActionDispatch::Request proxy for the socket connection
  #   - session     - the ActionDispatch::Session store for the current visitor
  #   - flash       - the ActionDispatch::Flash::FlashHash for the current request
  #   - url         - the URL of the page that triggered the reflex
  #   - params      - parameters from the element's closest form (if any)
  #   - element     - a Hash like object that represents the HTML element that triggered the reflex
  #     - signed    - use a signed Global ID to map dataset attribute to a model eg. element.signed[:foo]
  #     - unsigned  - use an unsigned Global ID to map dataset attribute to a model  eg. element.unsigned[:foo]
  #   - cable_ready - a special cable_ready that can broadcast to the current visitor (no brackets needed)
  #   - reflex_id   - a UUIDv4 that uniquely identies each Reflex
  #
  # Example:
  #
  #   before_reflex do
  #     # throw :abort # this will prevent the Reflex from continuing
  #     # learn more about callbacks at https://docs.stimulusreflex.com/lifecycle
  #   end
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com/reflexes#reflex-classes

  def update_notes
    TestCase.find_by(id: element.dataset[:id])&.update notes: element[:value]
    morph :nothing
  end

  def update_solution
    TestCase.find_by(id: element.dataset[:id])&.update additional_solution: element[:value]
    morph :nothing
  end  

  def update_month
    TestCase.find_by(id: element.dataset[:id])&.update volume_per_month: element[:value]
    morph :nothing
  end

  def update_assigned_to
    TestCase.find_by(id: element.dataset[:id])&.update assigned_to: element[:value]
    morph :nothing
  end  

  def toggle_value
    test_case = TestCase.find_by(id: element.dataset[:id])
    test_case.update(element.dataset[:field] => !test_case[element.dataset[:field]])
    morph :nothing
  end
end
